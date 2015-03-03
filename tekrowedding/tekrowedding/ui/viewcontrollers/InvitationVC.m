//
//  InvitationVC.m
//  tekrowedding
//
//  Created by Pau Moreno on 28/1/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "InvitationVC.h"
#import "ColorHelper.h"
#import "InterfaceHelper.h"
#import "ContentProvider.h"

#define PAPER_INVITATION_ALERT_CANCEL_BUTTON 0

@interface InvitationVC ()
{
    BOOL _didSetUpTabBar;
}

@property (weak, nonatomic) IBOutlet UIButton *printInvitationBtn;

@end

@implementation InvitationVC

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:THEME_COLOR];
    [self setupPaperInvitationButton];
    [self addNotificationObservers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (!_didSetUpTabBar) {
        [self.navigationController setTabBarItem:[self.tabBarItem initWithTitle:NSLocalizedString(@"tab_title_invitation", nil)
                                                                          image:[[InterfaceHelper getImageWithName:@"icon_invitation" andTintColor:THEME_PURPLE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  selectedImage:[[InterfaceHelper getImageWithName:@"icon_invitation_selected" andTintColor:THEME_PURPLE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
        _didSetUpTabBar = YES;
    }

    [self.navigationController setNavigationBarHidden:YES];
}

- (void)dealloc
{
    [self removeNotificationObservers];
}

#pragma mark - User Interface

- (void)setupPaperInvitationButton
{
    [_printInvitationBtn.titleLabel setNumberOfLines:0];
    [_printInvitationBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_printInvitationBtn setTitleColor:THEME_PURPLE forState:UIControlStateSelected];
    [_printInvitationBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    [_printInvitationBtn setTitleColor:THEME_PINK forState:UIControlStateHighlighted];
    [_printInvitationBtn setTitle:NSLocalizedString(@"print_invitation", nil) forState:UIControlStateNormal];
    [_printInvitationBtn setTitle:NSLocalizedString(@"paper_invitation_sent", nil) forState:UIControlStateSelected];
    [self updatePaperInvitationButtonForCurrentInvitation];
}

- (void)updatePaperInvitationButtonForCurrentInvitation
{
    if ([[ContentProvider sharedInstance] getCurrentInvitation].sendInvitation) {
        [_printInvitationBtn setSelected:YES];
        [_printInvitationBtn setUserInteractionEnabled:NO];
        [_printInvitationBtn setBackgroundColor:[UIColor clearColor]];
        [_printInvitationBtn.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    } else {
        [_printInvitationBtn setUserInteractionEnabled:YES];
        [_printInvitationBtn setBackgroundColor:THEME_PURPLE];
        [_printInvitationBtn setTintColor:THEME_COLOR];
        [_printInvitationBtn.layer setCornerRadius:3.f];
    }
}

#pragma mark - User Interaction

- (IBAction)didTapPaperInvitationButton:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert.paperinvitation.lang.title", nil)
                                message:NSLocalizedString(@"alert.paperinvitation.lang.message", nil)
                               delegate:self
                      cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                      otherButtonTitles:NSLocalizedString(@"alert.paperinvitation.es", nil), NSLocalizedString(@"alert.paperinvitation.cat", nil), nil] show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != PAPER_INVITATION_ALERT_CANCEL_BUTTON) {
        NSString *language = [[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"alert.paperinvitation.cast"] ? @"es" : @"cat";
        [[ContentProvider sharedInstance] askForPaperInvitationWithLanguage:language];
    }
}

#pragma mark - Notification methods

- (void)addNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePaperInvitationButtonForCurrentInvitation) name:@"invitationUpdateDidFinish" object:nil];
}

- (void)removeNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"invitationUpdateDidFinish" object:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showInvitationDetail"]) {
        MWPhotoBrowser *photoBrowserVC = (MWPhotoBrowser *)segue.destinationViewController;
        [photoBrowserVC setDelegate:self];
        [photoBrowserVC setEnableGrid:NO];
        [photoBrowserVC setStartOnGrid:NO];
    }
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return 1;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    return [MWPhoto photoWithImage:[UIImage imageNamed:@"invitation"]];
}

@end
