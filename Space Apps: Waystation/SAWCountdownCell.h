//
//  SAWCountdownCell.h
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-05-04.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAWCountdownCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *countdownText;
@property (retain, nonatomic) IBOutlet UILabel *cityText;
@property (retain, nonatomic) IBOutlet UILabel *numHoursText;
@property (retain, nonatomic) IBOutlet UILabel *hoursLabelText;
@property (retain, nonatomic) IBOutlet UILabel *numMinutesText;
@property (retain, nonatomic) IBOutlet UILabel *minutesLabelText;
@property (retain, nonatomic) IBOutlet UILabel *numSecondsText;
@property (retain, nonatomic) IBOutlet UILabel *secondsLabelText;

- (void) setup;

@end
