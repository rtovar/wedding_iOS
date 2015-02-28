//
//  MenuVC.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "MenuVC.h"
#import "Guest.h"
#import "ContentProvider.h"
#import "ColorHelper.h"

@interface MenuVC()
{
    Guest *_guest;
}

@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *meatButton;
@property (strong, nonatomic) IBOutlet UIButton *fishButton;
@property (strong, nonatomic) IBOutlet UIButton *veggieButton;
@property (strong, nonatomic) IBOutlet UIButton *childButton;
@property (strong, nonatomic) IBOutlet UIButton *otherButton;
@property (strong, nonatomic) IBOutlet UITextField *otherTextField;

@end

@implementation MenuVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGuest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveData];
}

#pragma mark - User Interface

- (void)setupGuest
{
    _guest = [ContentProvider sharedInstance].currentGuest;
    NSString *menuString;
    NSString *menuKey = @"menu_";
    
    if (_guest.menu) {
        menuKey = [NSString stringWithFormat:@"%@%@", menuKey, _guest.menu];
        menuString = NSLocalizedString(menuKey, @"");
    }
    
    [self selectButtonsWithMenu:menuString];
    [self setupOtherTextField];
    
}

- (void)setupButtons
{
    [self setupButton:_meatButton];
    [self setupButton:_fishButton];
    [self setupButton:_veggieButton];
    [self setupButton:_childButton];
    [self setupButton:_otherButton];
}

- (void)setupButton:(UIButton *)button
{
    [button setTitleColor:[THEME_PINK colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
    [button setTitleColor:THEME_PINK forState:UIControlStateSelected];
}

- (void)selectButtonsWithMenu:(NSString *)menuString
{
    [_meatButton setSelected:menuString && [menuString isEqualToString:_meatButton.titleLabel.text]];
    [_fishButton setSelected:menuString && [menuString isEqualToString:_fishButton.titleLabel.text]];
    [_veggieButton setSelected:menuString && [menuString isEqualToString:_veggieButton.titleLabel.text]];
    [_childButton setSelected:menuString && [menuString isEqualToString:_childButton.titleLabel.text]];
    [_otherButton setSelected:menuString && [menuString isEqualToString:_otherButton.titleLabel.text]];
}

- (void)setupOtherTextField
{
    if ([_otherButton isSelected]) {
        [_otherTextField setEnabled:YES];
        [_otherTextField setText:_guest.menuOther];
    } else {
        [_otherTextField setSelected:NO];
    }
}

#pragma mark - User Interaction

- (void)saveData
{
    if ([_otherButton isSelected]) {
        [_guest setMenuOther:_otherTextField.text];
    }
    
    [[ContentProvider sharedInstance] updateGuest:_guest];
}

- (IBAction)didTouchIpInsideSaveButton:(id)sender
{
    [self saveData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTouchIpInsideMeatButton:(id)sender
{
    [_guest setMenu:@"meat"];
    [self setupGuest];
}

- (IBAction)didTouchIpInsideFishButton:(id)sender
{
    [_guest setMenu:@"fish"];
    [self setupGuest];
}

- (IBAction)didTouchIpInsideVeggieButton:(id)sender
{
    [_guest setMenu:@"veggie"];
    [self setupGuest];
}

- (IBAction)didTouchIpInsideChildButton:(id)sender
{
    [_guest setMenu:@"child"];
    [self setupGuest];
}

- (IBAction)didTouchIpInsideOtherButton:(id)sender
{
    [_guest setMenu:@"other"];
    [self setupGuest];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self saveData];
}

@end
