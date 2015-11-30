//
//  Reminder.h
//  LocationCF
//
//  Created by Heidi Yee on 11/29/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

#import <Parse/Parse.h>

@import Parse;

@interface Reminder : PFObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSNumber *radius;
@property (strong, nonatomic) NSString *user;

@end
