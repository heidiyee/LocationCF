//
//  ViewController.m
//  LocationCF
//
//  Created by Heidi Yee on 11/23/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "ViewController.h"
#import "LocationController.h"
#import "DetailedViewController.h"


@interface ViewController () <LocationControllerDelegate, MKMapViewDelegate>

@property(strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[LocationController SharedController]start];
    [[LocationController SharedController]setDelegate:self];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[LocationController SharedController]stop];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailedViewController"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotationView = (MKAnnotationView *) sender;
            DetailedViewController *detailedViewController = (DetailedViewController *)segue.destinationViewController;
            detailedViewController.annotationTitle = annotationView.annotation.title;
            detailedViewController.coordinate = annotationView.annotation.coordinate;
        }
    }
}

#pragma mark - LocationControllerDelegate

-(void)locationControllerDidUpdateLocation:(CLLocation *)location {
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 400, 400) animated:YES];
}

#pragma mark - IBActions

- (IBAction)locationButtonSelected:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        NSString *buttonTitle = button.titleLabel.text;
        //self.mapView.showsUserLocation = NO;
        
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

- (IBAction)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint touchpoint = [gesture locationInView:self.mapView];
        CLLocationCoordinate2D gestureCoordinate = [self.mapView convertPoint:touchpoint toCoordinateFromView:self.mapView];
        
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.coordinate = gestureCoordinate;
        annotation.title = @"Hello";
        annotation.subtitle = @"Let's go here";
        [self.mapView addAnnotation:annotation];
    }
    
    
}

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"likedAreas"];
    annotationView.annotation = annotation;
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"likedAreas"];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    annotationView.pinColor = MKPinAnnotationColorPurple;
    UIButton *rightCallout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCallout;
    
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"DetailedViewController" sender:view];
}




@end
