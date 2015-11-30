//
//  DetailedViewController.m
//  LocationCF
//
//  Created by Heidi Yee on 11/24/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import "DetailedViewController.h"
#import "LocationController.h"
#import "Reminder.h"

@import Parse;


@interface DetailedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *reminderTitle;
@property (weak, nonatomic) IBOutlet UITextField *circleRadius;

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.annotationTitle);
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    PFUser *currentUser = [PFUser currentUser];
    
    Reminder *reminder = [[Reminder alloc]initWithClassName:@"Reminder"];
    reminder.name = self.reminderTitle.text;
    reminder.radius = [NSNumber numberWithFloat:self.circleRadius.text.floatValue];
    reminder.user = currentUser.username;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [reminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        NSLog(@"Reminder saved to Parse.");
        
        if (self.completion) {
            
            // Check for abilities then...
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                
                // Create new region and...
                CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:self.circleRadius.text.floatValue identifier:self.reminderTitle.text];
                [[[LocationController SharedController]locationManager]startMonitoringForRegion:region];
                NSLog(@"Monitoring");

                
                // Pass it back to be added to the map.
                self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:self.circleRadius.text.floatValue]);
                
                // Dismiss.
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

@end
