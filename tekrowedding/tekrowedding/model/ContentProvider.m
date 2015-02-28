//
//  ContentProvider.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "ContentProvider.h"
#import "NetworkHelper.h"

@interface ContentProvider ()
{
    Invitation *_invitation;
    NSString *_currentInvitationID;
}

@end

@implementation ContentProvider

+ (instancetype)sharedInstance
{
    static ContentProvider *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
                      sharedInstance = [[ContentProvider alloc] init];

                  });

    return sharedInstance;
}

- (void)updateGuest:(Guest *)guest
{
    [NetworkHelper updateGuest:guest fromInvitationWithID:_currentInvitationID withSucessBlock:[self invitationSuccessBlock] failureBlock:[self invitationFailureBlock]];
}

- (SuccessBlock)invitationSuccessBlock
{
    return ^(AFHTTPRequestOperation *operation, id responseObject) {
        _invitation = [[Invitation alloc] initWithDictionary:responseObject];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"invitationUpdateDidFinish" object:nil];
    };
}

- (FailureBlock)invitationFailureBlock
{
    return ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"invitationUpdateDidFinish" object:nil];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:NSLocalizedString(@"alert.menu.message", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"ok", nil)
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    };
}

- (NSString *)getCurrentInvitationID
{
    if (!_currentInvitationID) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _currentInvitationID = [userDefaults objectForKey:@"invitationID"];
    }
    
    return _currentInvitationID;
}

- (Invitation *)getCurrentInvitation
{
    return _invitation;
}

- (void)setCurrentInvitation:(Invitation *)currentInvitation
{
    _currentInvitationID = currentInvitation.identifier;
    _invitation = currentInvitation;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_currentInvitationID forKey:@"invitationID"];
    [userDefaults synchronize];
}

- (void)askForPaperInvitationWithLanguage:(NSString *)language
{
    [_invitation setSendInvitation:YES];
    [_invitation setInvitationLanguage:language];
    [NetworkHelper askForPaperInvitation:_invitation withSuccessBlock:[self invitationSuccessBlock] failureBlock:[self invitationFailureBlock]];
}

@end
