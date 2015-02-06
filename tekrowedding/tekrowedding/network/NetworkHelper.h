//
//  NetworkHelper.h
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

static NSString *const kBaseURLString = @"http://mostrolabs.com:8090/";

typedef void (^SuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface NetworkHelper : NSObject

+ (void)getInvitationWithID:(NSString *)invitationID succeessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
