//
//  SAWStationPassCell.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-05-04.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWStationPassCell.h"

@implementation SAWStationPassCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.dateText.font = [UIFont fontWithName:@"Gotham-Medium" size:13];
    self.dateText.textColor = [UIColor colorWithRed:137/255.0 green:137/225.0 blue:137/255.0 alpha:1];
    self.dateText.highlightedTextColor = [UIColor colorWithRed:137/255.0 green:137/225.0 blue:137/255.0 alpha:1];
    self.dateText.text =@"April 2";
    
    self.visibleForLabel.font = [UIFont fontWithName:@"Gotham-Medium" size:13];
    self.visibleForLabel.textColor = [UIColor colorWithRed:137/255.0 green:137/225.0 blue:137/255.0 alpha:1];
    self.visibleForLabel.highlightedTextColor = [UIColor colorWithRed:137/255.0 green:137/225.0 blue:137/255.0 alpha:1];
    
    self.timeText.font = [UIFont fontWithName:@"Gotham-Light" size:50];
    self.timeText.textColor = [UIColor colorWithRed:34/255.0 green:34/225.0 blue:34/255.0 alpha:1];
    self.timeText.highlightedTextColor = [UIColor colorWithRed:34/255.0 green:34/225.0 blue:34/255.0 alpha:1];
    self.timeText.text=@"4:07";
    self.timeUnitText.font = [UIFont fontWithName:@"Gotham-Light" size:20];
    self.timeUnitText.textColor = [UIColor colorWithRed:34/255.0 green:34/225.0 blue:34/255.0 alpha:1];
    self.timeUnitText.highlightedTextColor = [UIColor colorWithRed:34/255.0 green:34/225.0 blue:34/255.0 alpha:1];
}

- (void)dealloc {
    [_dateText release];
    [_visibleForLabel release];
    [_timeText release];
    [_weatherIcon release];
    [_notificationToggle release];
    [_timeUnitText release];
    [super dealloc];
}
@end
