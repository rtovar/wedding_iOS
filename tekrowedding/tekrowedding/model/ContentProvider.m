//
//  ContentProvider.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "ContentProvider.h"

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

@end
