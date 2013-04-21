//
//  SAWTimingViewController.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-21.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWTimingViewController.h"
#import "SAWPhotoViewController.h"
#import "SAWAppDelegate.h"

@interface SAWTimingViewController ()

@end

@implementation SAWTimingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)spotTheSpaceStation:(id)sender {
//    [self.navigationController pushViewController:[[[SAWPhotoViewController alloc]initWithNibName:@"SAWPhotoViewController" bundle:nil]autorelease] animated:YES];
}
- (IBAction)left:(id)sender {
//    UINavigationController *navController = self.navigationController;
//    [[navController retain]autorelease];
//    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_spot release];
    [_menuButton release];
    [super dealloc];
}
@end
