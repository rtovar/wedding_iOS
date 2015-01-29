//
//  InfoVC.m
//  tekrowedding
//
//  Created by Rocio Tovar on 28/1/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "InfoVC.h"
#import <MapKit/MapKit.h>

@interface InfoVC ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation InfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLocation];
}

- (void)setLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder geocodeAddressString:@"Carretera c-31, km. 191, El Prat de Llobregat"
                 completionHandler:^(NSArray *placemarks, NSError *error){
         for (CLPlacemark * aPlacemark in placemarks) {
             // Set map point
             MKPointAnnotation *point = [MKPointAnnotation new];
             [point setCoordinate:[[aPlacemark location] coordinate]];
             [point setTitle:[aPlacemark locality]];

             // Set map region
             MKCoordinateRegion region = _mapView.region;
             region.center = aPlacemark.location.coordinate;
             region.span.longitudeDelta = 1;
             region.span.latitudeDelta = 1;

             // Add point to the map
             [_mapView setRegion:region animated:NO];
             [_mapView addAnnotation:point];

             // Select the PointAnnotation programatically
             [_mapView selectAnnotation:point animated:YES];
         }
     }];
}

- (IBAction)mapButtonWasTapped:(id)sender
{
    NSArray *annotations = [_mapView annotations];

    if (annotations && annotations.count == 1) {
        MKPlacemark *mkDest = [[MKPlacemark alloc] initWithCoordinate:((id<MKAnnotation>)annotations[0]).coordinate
                                                    addressDictionary:nil];
        [[[MKMapItem alloc] initWithPlacemark:mkDest] openInMapsWithLaunchOptions:nil];
    }
}

@end
