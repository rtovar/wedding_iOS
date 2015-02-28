//
//  InfoVC.m
//  tekrowedding
//
//  Created by Rocio Tovar on 28/1/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "InfoVC.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import "InterfaceHelper.h"
#import "ColorHelper.h"

@interface InfoVC ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation InfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTabBarItem:[self.tabBarItem initWithTitle:NSLocalizedString(@"tab_title_info", nil)
                                                 image:[InterfaceHelper getImageWithName:@"icon_info" andTintColor:THEME_PURPLE]
                                         selectedImage:[InterfaceHelper getImageWithName:@"icon_info_selected" andTintColor:THEME_PURPLE]]];
    
    [self setLocation];
}

- (void)setLocation
{
    // Set map point
    MKPointAnnotation *point = [MKPointAnnotation new];
    [point setCoordinate:CLLocationCoordinate2DMake(41.3153128, 2.0659476)];
    [point setTitle:@"El Jardí de les Palmeres"];
    
    // Set map region
    MKCoordinateRegion region = _mapView.region;
    region.center = point.coordinate;
    region.span.longitudeDelta = 1;
    region.span.latitudeDelta = 1;
    
    // Add point to the map
    [_mapView setRegion:region animated:NO];
    [_mapView addAnnotation:point];
    
    // Select the PointAnnotation programatically
    [_mapView selectAnnotation:point animated:YES];
}

- (IBAction)mapButtonWasTapped:(id)sender
{
    NSArray *annotations = [_mapView annotations];

    if (annotations && annotations.count == 1) {
        MKPlacemark *mkDest = [[MKPlacemark alloc] initWithCoordinate:((id<MKAnnotation>)annotations[0]).coordinate
                                                    addressDictionary:@{(NSString*)kABPersonAddressStreetKey:@"El Jardí de les Palmeres"}];
        [[[MKMapItem alloc] initWithPlacemark:mkDest] openInMapsWithLaunchOptions:nil];
    }
}

@end
