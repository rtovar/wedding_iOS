//
//  GuestsVC.m
//  tekrowedding
//
//  Created by Rocio Tovar on 29/1/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "GuestsVC.h"
#import "GuestCell.h"
#import "ContentProvider.h"
#import "InterfaceHelper.h"
#import "ColorHelper.h"
#import "MenuVC.h"

@interface GuestsVC ()
{
    NSArray *_guestsArray;
    BOOL _didSetUpTabBar;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GuestsVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _guestsArray = [[ContentProvider sharedInstance] getCurrentInvitation].guests;
    [_tableView reloadData];
    [self addNotificationObservers];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_didSetUpTabBar) {
        [self.navigationController setTabBarItem:[self.tabBarItem initWithTitle:NSLocalizedString(@"tab_title_guests", nil)
                                                     image:[[InterfaceHelper getImageWithName:@"icon_guests" andTintColor:THEME_PURPLE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                             selectedImage:[[InterfaceHelper getImageWithName:@"icon_guests_selected" andTintColor:THEME_PURPLE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
        _didSetUpTabBar = YES;
    }
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)dealloc
{
    [self removeNotificationObservers];
}

- (UIRectEdge)edgesForExtendedLayout
{
    return [super edgesForExtendedLayout] ^ UIRectEdgeBottom;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_guestsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuestCell *cell = (GuestCell *)[_tableView dequeueReusableCellWithIdentifier:@"GuestCell"];

    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([tableView class]) owner:self options:nil];

        // retrieve cell
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = currentObject;
            }
        }
    }

    [cell setGuest:_guestsArray[indexPath.row]];

    return cell;

}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Guest *guest = _guestsArray[indexPath.row];
    if (guest.rsvp) {
        [[ContentProvider sharedInstance] setCurrentGuest:guest];
        [self performSegueWithIdentifier:@"showMenuVC" sender:self];
    }
}

#pragma mark - Notification methods

- (void)addNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGuestsForCurrentInvitation) name:@"invitationUpdateDidFinish" object:nil];
}

- (void)removeNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"invitationUpdateDidFinish" object:nil];
}

- (void)updateGuestsForCurrentInvitation
{
    [_tableView reloadData];
}

@end
