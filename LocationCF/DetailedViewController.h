//
//  DetailedViewController.h
//  LocationCF
//
//  Created by Heidi Yee on 11/24/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface DetailedViewController: UIViewController

@property (copy, nonatomic) NSString *annotationTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
