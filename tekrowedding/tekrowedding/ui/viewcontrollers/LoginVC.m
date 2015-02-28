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
#import "NetworkHelper.h"

@interface LoginVC ()
{
    NSString *_invitationID;
}

@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[ContentProvider sharedInstance] getCurrentInvitationID]) {
        _invitationID = [[ContentProvider sharedInstance] getCurrentInvitationID];
        [self requestInvitation];
    }
}

- (void)requestInvitation
{
    [_contentView setHidden:YES];
    [_activityIndicatorView setHidden:NO];
    [NetworkHelper getInvitationWithID:_invitationID successBlock:[self invitationSuccessBlock] failureBlock:[self invitationFailureBlock]];
}

- (SuccessBlock)invitationSuccessBlock
{
    return ^(AFHTTPRequestOperation *operation, id responseObject) {
        Invitation *invitation = [[Invitation alloc] initWithDictionary:responseObject];
        [[ContentProvider sharedInstance] setCurrentInvitation:invitation];
        [self performSegueWithIdentifier:@"showInvitation" sender:self];
    };
}

- (FailureBlock)invitationFailureBlock
{
    return ^(AFHTTPRequestOperation *operation, NSError *error) {
        [_activityIndicatorView setHidden:YES];
        [_contentView setHidden:NO];
        [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"error_request_invitation_message", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil] show];
    };
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showScanner"]) {
        ZBarReaderViewController *zbarVC = segue.destinationViewController;
        [zbarVC setReaderDelegate:self];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    for (ZBarSymbol * object in results) {
        NSLog(@"%@",object.data);
        _invitationID = object.data;
    }
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        if (_invitationID) {
            [self requestInvitation];
        }
    }];
}


@end
