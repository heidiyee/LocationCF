//
//  ViewController.m
//  LocationCF
//
//  Created by Heidi Yee on 11/23/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestPermissions];
    [self.mapView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestPermissions {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
}

@end
