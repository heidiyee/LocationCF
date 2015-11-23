//
//  ViewController.m
//  LocationCF
//
//  Created by Heidi Yee on 11/23/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate>

@property(strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestPermissions];
    [self zoomInUserLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)requestPermissions {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    
}

- (IBAction)locationButtonSelected:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        NSString *buttonTitle = button.titleLabel.text;
        
        if ([buttonTitle isEqualToString:@"Location 1"]) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6902328,-122.4016132);
            [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000) animated:YES];
        }
        if ([buttonTitle isEqualToString:@"Location 2"]) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6235769,-122.3382575);
            [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000) animated:YES];
        }
        if ([buttonTitle isEqualToString:@"Location 3"]) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(-8.8122194,115.2183548);
            [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 20000, 20000) animated:YES];
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = YES;
    }
}

-(void)zoomInUserLocation {
//    MKCoordinateRegion mapRegion;
//    mapRegion.center = self.mapView.userLocation.coordinate;
//    mapRegion.span.latitudeDelta = 0.2;
//    mapRegion.span.longitudeDelta = 0.2;
    
    
    self.mapView.showsUserLocation = YES;
}

@end
