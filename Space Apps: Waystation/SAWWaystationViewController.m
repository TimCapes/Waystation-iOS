//
//  SAWWaystationViewController.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-20.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWWaystationViewController.h"


@interface SAWWaystationViewController ()
@property (nonatomic, strong) CLGeocoder *geocoder;
@end

@implementation SAWWaystationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)menuButton:(id)sender {
    [self.root showLeftController:YES];
}
- (IBAction)spotButton:(id)sender {
    [self.root showRightController:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
     self.mapView.mapType = MKMapTypeSatellite;
    self.geocoder = [[CLGeocoder alloc] init];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mapView release];
    [_greetings release];
    [_scrollView release];
    [super dealloc];
}
- (NSMutableDictionary *) addressForSending {
    NSLog(self.placemark.locality);
    NSLog(self.placemark.administrativeArea);
    NSLog(self.placemark.country);
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:self.placemark.locality,@"City",self.placemark.administrativeArea, @"StateProv",self.placemark.country,@"Country",nil];
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft ||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        [self.scrollView setFrame:CGRectMake(0,500,200,320)];
        [self.view sendSubviewToBack:self.greetings];
        [self.mapView setFrame:CGRectMake(0,0,568,320)];
    } else {

        [self.mapView setFrame:CGRectMake(0,0,320,330)];
        [self.scrollView setFrame:CGRectMake(0,368,320,200)];
        [self.greetings setFrame: CGRectMake(0,330,320,38)];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        _placemark = [placemarks objectAtIndex:0];
        [self addressForSending];
    }];
}


@end
