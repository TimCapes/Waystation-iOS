//
//  SAWFullScreenCell.h
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-21.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAWFullScreenCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIButton *settings;
@property (retain, nonatomic) IBOutlet UIButton *homeButton;
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (retain, nonatomic) IBOutlet UIButton *schedule;
@property (retain, nonatomic) IBOutlet UIButton *notifcations;

@end
