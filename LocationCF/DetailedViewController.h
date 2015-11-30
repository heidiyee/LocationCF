//
//  DetailedViewController.h
//  LocationCF
//
//  Created by Heidi Yee on 11/24/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

@import UIKit;
@import MapKit;

typedef void(^DetailedViewControllerCompletion)(MKCircle *circle);

@interface DetailedViewController: UIViewController

@property (strong, nonatomic) NSString *annotationTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) DetailedViewControllerCompletion completion;


@end
