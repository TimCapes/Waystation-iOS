//
//  SAWAppDelegate.h
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-20.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "SAWWaystationViewController.h"
@interface SAWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) NSMutableDictionary *dataForTweet;

@end
