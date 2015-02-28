//
//  GuestCell.m
//  tekrowedding
//
//  Created by Rocio Tovar on 29/1/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "GuestCell.h"
#import "InterfaceHelper.h"
#import "ColorHelper.h"
#import "ContentProvider.h"
#import "NetworkHelper.h"

@interface GuestCell ()
{
    Guest *_guest;
}

@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *rsvpButton;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation GuestCell

- (void)setGuest:(Guest *)guest
{
    _guest = guest;

    [_firstNameLabel setText:_guest.firstName];
    [_lastNameLabel setText:_guest.lastName];
    [_menuButton setHidden:!_guest.rsvp];
    
    NSString *menuString;
    if (_guest.menu && ![_guest.menu isEqualToString:@"other"]) {
        NSString *menuKey = [NSString stringWithFormat:@"menu_%@", _guest.menu];
        menuString = NSLocalizedString(menuKey, nil);
    } else if (_guest.menu) {
        menuString = _guest.menuOther;
    } else {
        menuString = NSLocalizedString(@"menu_unknown", nil);
    }
    
    [_menuButton setTitle:menuString forState:UIControlStateNormal];
    [_rsvpButton setImage:[InterfaceHelper getImageWithName:@"ic_rsvp" andTintColor:[ColorHelper color:THEME_PINK blendedWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] withAlpha:0.4]] forState:UIControlStateNormal];
    [_rsvpButton setImage:[InterfaceHelper getImageWithName:@"ic_rsvp" andTintColor:THEME_PINK] forState:UIControlStateSelected];
    [_rsvpButton setSelected:_guest.rsvp];
}

- (IBAction)didTouchInsideUpRSVPButton:(UIButton *)sender
{
    [sender setSelected:!sender.isSelected];
    [_guest setRsvp:sender.isSelected];
    [[ContentProvider sharedInstance] updateGuest:_guest];
}

@end
