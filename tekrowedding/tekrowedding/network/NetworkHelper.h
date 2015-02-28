//
//  NetworkHelper.h
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ContentProvider.h"

static NSString *const kBaseURLString = @"http://mostrolabs.com:8090/";

typedef void (^SuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface NetworkHelper : NSObject

+ (void)getInvitationWithID:(NSString *)invitationID successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
+ (void)updateGuest:(Guest *)guest fromInvitationWithID:(NSString *)invitationID withSucessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
+ (void)askForPaperInvitation:(Invitation *)invitation withSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
