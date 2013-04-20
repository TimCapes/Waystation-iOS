//
//  SAWWaystationViewController.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-20.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWWaystationViewController.h"
#import "SAWSineWaveView.h"
#import "SAWAppDelegate.h"
@interface SAWWaystationViewController (){
   // CAShapeLayer *rectLayer;
}
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) SAWSineWaveView *sineWave;
@property (nonatomic, strong) UIProgressView *progressView;
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
    self.sineWave = [[[SAWSineWaveView alloc] initWithFrame:CGRectMake(0,0,320,338)]autorelease];
    self.sineWave.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:self.sineWave];
    [self.view sendSubviewToBack:self.sineWave];
    [self.view sendSubviewToBack:self.mapView];
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
    NSLog([NSMutableString stringWithFormat:@"Latitude: %f",self.mapView.userLocation.location.coordinate.latitude]);
    NSLog([NSMutableString stringWithFormat:@"Longitude: %f",self.mapView.userLocation.location.coordinate.longitude]);
    NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
    NSMutableString *date = [NSMutableString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    NSMutableString *latitude = [NSMutableString stringWithFormat:@"%f",self.mapView.userLocation.location.coordinate.latitude];
    NSMutableString *longitude = [NSMutableString stringWithFormat:@"%f",self.mapView.userLocation.location.coordinate.longitude];
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.placemark.locality, @"City", self.placemark.administrativeArea, @"StateProv",self.placemark.country, @"Country", date, @"Date",@"longitude",longitude,@"latitude",latitude, nil];
    //
    // self.mapView.userLocation.location.coordinate.longitude, @"Longitude", self.mapView.userLocation.location.coordinate.latitude, @"Latitude",
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft ||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        //[self.scrollView setFrame:CGRectMake(0,500,200,320)];
        [self.view sendSubviewToBack:self.greetings];
        [self.mapView setFrame:CGRectMake(0,0,568,320)];
        [self.sineWave setFrame:CGRectMake(0,0,568,320)];
        //self.progressView = [[[UIProgressView alloc]initWithFrame:CGRectMake(20,280,540,300)]autorelease];
        //[self.progressView setFrame:CGRectMake];
        [self.view addSubview: self.progressView];
    } else {

        [self.mapView setFrame:CGRectMake(0,0,320,330)];
        [self.sineWave setFrame:CGRectMake(0,0,320,330)];
        [self.progressView removeFromSuperview];
        self.progressView = nil;
        //[self.scrollView setFrame:CGRectMake(0,368,320,200)];
       // [self.greetings setFrame: CGRectMake(0,330,320,38)];
    }
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        _placemark = [placemarks objectAtIndex:0];
        SAWAppDelegate *appDelegate = (SAWAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.dataForTweet = [self addressForSending];
    }];
}


@end
