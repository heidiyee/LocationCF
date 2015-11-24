//
//  LocationController.m
//  LocationCF
//
//  Created by Heidi Yee on 11/24/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "LocationController.h"

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
    
}

@end

