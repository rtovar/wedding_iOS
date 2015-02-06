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
    [_rsvpButton setEnabled:_guest.rsvp];
    [_menuButton setHidden:!_guest.rsvp];
    [_menuButton setTitle:NSLocalizedString(_guest.menu, nil) forState:UIControlStateNormal];

    [_rsvpButton setImage:[InterfaceHelper getImageWithName:@"ic_rsvp" andTintColor:[THEME_PINK colorWithAlphaComponent:0.4]] forState:UIControlStateNormal];
    [_rsvpButton setImage:[InterfaceHelper getImageWithName:@"ic_rsvp" andTintColor:THEME_PINK] forState:UIControlStateSelected];
}

@end
