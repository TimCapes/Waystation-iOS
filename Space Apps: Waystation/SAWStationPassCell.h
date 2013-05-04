//
//  SAWStationPassCell.h
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-05-04.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAWStationPassCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *dateText;
@property (retain, nonatomic) IBOutlet UILabel *visibleForLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeText;
@property (retain, nonatomic) IBOutlet UILabel *timeUnitText;

@property (retain, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (retain, nonatomic) IBOutlet UIButton *notificationToggle;

- (void) setup;
@end
