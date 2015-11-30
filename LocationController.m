//
//  LocationController.m
//  LocationCF
//
//  Created by Heidi Yee on 11/24/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "LocationController.h"

@interface LocationController () <CLLocationManagerDelegate>

@end

@implementation LocationController 

+ (LocationController *) SharedController {
    static LocationController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[[self class]alloc]init];
    });
    return sharedController;
}

-(instancetype) init {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100;
        
        [_locationManager requestWhenInUseAuthorization];
    }
    return self;
}

-(void)start {
    [self.locationManager startUpdatingLocation];
}

-(void)stop {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.delegate locationControllerDidUpdateLocation:(locations.lastObject)];
    [self setLocation:[locations lastObject]];
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    NSLog(@"Region entered");
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertTitle = @"Region entered";
    notification.alertBody = @"I hope this works";
    [[UIApplication sharedApplication]presentLocalNotificationNow:notification];
}


@end

