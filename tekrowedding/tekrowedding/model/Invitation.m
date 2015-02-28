//
//  Invitation.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "Invitation.h"
#import "Guest.h"

@implementation Invitation

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (self) {
        [self setIdentifier:dict[@"_id"]];
        [self setSendInvitation:[dict.allKeys containsObject:@"sendInvitation"] ? [dict[@"sendInvitation"] boolValue] : NO];
        [self setInvitationLanguage:[dict.allKeys containsObject:@"invitationLanguage"] ? dict[@"invitationLanguage"] : nil];
        [self addGuestsFromResponseDict:dict];
    }
    
    return self;
}

- (void)addGuestsFromResponseDict:(NSDictionary *)dict
{
    if ([dict.allKeys containsObject:@"guests"]) {
        NSMutableArray *guestsArray = [@[] mutableCopy];
        
        for (NSDictionary *guestDict in dict[@"guests"]) {
            Guest *guest = [[Guest alloc] initWithDictionary:guestDict];
            [guestsArray addObject:guest];
        }
        
        [self setGuests:guestsArray];
    }
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [@{} mutableCopy];
    
    if (_identifier) {
        dict[@"_id"] = _identifier;
    }
    if (_sendInvitation) {
        dict[@"sendInvitation"] = @(_sendInvitation);
    }
    if (_invitationLanguage) {
        dict[@"invitationLanguage"] = _invitationLanguage;
    }
    
    dict = [self addGuestsToDictRepresentation:dict];
    
    return dict;
}

- (NSMutableDictionary *)addGuestsToDictRepresentation:(NSMutableDictionary *)dict
{
    if (_guests && _guests.count > 0) {
        NSMutableArray *guestsArray = [@[] mutableCopy];
        
        for (Guest *guest in _guests) {
            [guestsArray addObject:[guest dictionaryRepresentation]];
        }
        
        dict[@"guests"] = guestsArray;
    }
    
    return dict;
}

@end
