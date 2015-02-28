//
//  Invitation.h
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Invitation : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSArray *guests;
@property (nonatomic, assign) BOOL sendInvitation;
@property (nonatomic, strong) NSString *invitationLanguage;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
