//
//  Guest.h
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Guest : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) BOOL rsvp;
@property (nonatomic, strong) NSString *menu;

@end
