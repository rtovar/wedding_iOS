//
//  Guest.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "Guest.h"

@implementation Guest

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (self) {
        [self setIdentifier:dict[@"id"]];
        [self setFirstName:[dict.allKeys containsObject:@"firstName"] ? dict[@"firstName"] : nil];
        [self setLastName:[dict.allKeys containsObject:@"lastName"] ? dict[@"lastName"] : nil];
        [self setRsvp:[dict.allKeys containsObject:@"rsvp"] ? [dict[@"rsvp"] boolValue] : NO];
        [self setMenu:[dict.allKeys containsObject:@"menu"] ? dict[@"menu"] : nil];
        [self setMenuOther:[dict.allKeys containsObject:@"menuOther"] ? dict[@"menuOther"] : nil];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [@{} mutableCopy];
    if (_identifier) {
        dict[@"id"] = _identifier;
    }
    if (_firstName) {
        dict[@"firstName"] = _firstName;
    }
    if (_lastName) {
        dict[@"lastName"] = _lastName;
    }
    dict[@"rsvp"] = @(_rsvp);
    if (_menu) {
        dict[@"menu"] = _menu;
    }
    if (_menuOther) {
        dict[@"menuOther"] = _menuOther;
    }
    
    return dict;
}

@end
