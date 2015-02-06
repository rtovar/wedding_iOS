//
//  LoginVC.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "LoginVC.h"
#import "NetworkHelper.h"
#import "ContentProvider.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NetworkHelper getInvitationWithID:@"54ce5d7b362ac02776f6ffd8" succeessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
         [[ContentProvider sharedInstance] setInvitation:responseObject];
         [self performSegueWithIdentifier:@"showInvitation" sender:self];
     } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
     }];
}

@end
