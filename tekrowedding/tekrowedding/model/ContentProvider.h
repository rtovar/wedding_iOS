//
//  ContentProvider.h
//  ;
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Invitation.h"
#import "Guest.h"


@interface ContentProvider : NSObject

@property (nonatomic, strong) NSString *currentInvitationID;
@property (nonatomic, strong) Guest *currentGuest;

+ (instancetype)sharedInstance;
- (void)updateGuest:(Guest *)guest;
- (NSString *)getCurrentInvitationID;
- (Invitation *)getCurrentInvitation;
- (void)setCurrentInvitation:(Invitation *)currentInvitation;
- (void)askForPaperInvitationWithLanguage:(NSString *)language;

@end
