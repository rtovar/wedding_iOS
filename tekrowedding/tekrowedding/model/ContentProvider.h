//
//  ContentProvider.h
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Invitation.h"

@interface ContentProvider : NSObject

@property (nonatomic, strong) Invitation *invitation;

+ (instancetype)sharedInstance;

@end
