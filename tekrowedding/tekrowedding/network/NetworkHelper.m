//
//  NetworkHelper.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "NetworkHelper.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@implementation NetworkHelper

+ (void)getInvitationWithID:(NSString *)invitationID successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@invite/%@", kBaseURLString, invitationID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [operation setCompletionBlockWithSuccess:successBlock failure:failureBlock];
    [operation start];
}

+ (void)updateGuest:(Guest *)guest fromInvitationWithID:(NSString *)invitationID withSucessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@invite/%@/%@", kBaseURLString, invitationID, guest.identifier];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:urlString parameters:[guest dictionaryRepresentation] success:successBlock failure:failureBlock];
}

+ (void)askForPaperInvitation:(Invitation *)invitation withSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@invite/%@", kBaseURLString, invitation.identifier];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:urlString parameters:[invitation dictionaryRepresentation] success:successBlock failure:failureBlock];
}

@end
