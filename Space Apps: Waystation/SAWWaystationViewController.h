//
//  SAWWaystationViewController.h
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-20.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import <MapKit/MapKit.h>

@interface SAWWaystationViewController : UIViewController
@property(nonatomic, retain) DDMenuController *root;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UIImageView *greetings;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) MKPlacemark *placemark;

-(NSMutableDictionary *) addressForSending;

@end
