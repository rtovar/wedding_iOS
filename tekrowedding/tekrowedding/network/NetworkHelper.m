//
//  NetworkHelper.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "NetworkHelper.h"
#import "ContentProvider.h"

@implementation NetworkHelper

+ (void)getInvitationWithID:(NSString *)invitationID succeessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@invite/%@", kBaseURLString, invitationID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [operation setCompletionBlockWithSuccess:successBlock failure:failureBlock];
    [operation start];
}

@end
