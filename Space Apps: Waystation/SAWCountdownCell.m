//
//  SAWCountdownCell.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-05-04.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWCountdownCell.h"

@implementation SAWCountdownCell


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

- (void)dealloc {
    [_countdownText release];
    [_cityText release];
    [_numHoursText release];
    [_hoursLabelText release];
    [_numMinutesText release];
    [_minutesLabelText release];
    [_numSecondsText release];
    [_secondsLabelText release];
    [super dealloc];
}
- (void) setup {
    self.numHoursText.font = [UIFont fontWithName:@"Gotham-Medium" size:27];
    self.numHoursText.textColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    self.numHoursText.highlightedTextColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    
    self.numMinutesText.font = [UIFont fontWithName:@"Gotham-Medium" size:27];
    self.numMinutesText.textColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    self.numMinutesText.highlightedTextColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    
    self.numSecondsText.font = [UIFont fontWithName:@"Gotham-Medium" size:27];
    self.numSecondsText.textColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    self.numSecondsText.highlightedTextColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    
    self.hoursLabelText.font = [UIFont fontWithName:@"Gotham-Light" size:27];
    self.hoursLabelText.textColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    self.hoursLabelText.highlightedTextColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    
    self.minutesLabelText.font = [UIFont fontWithName:@"Gotham-Light" size:27];
    self.minutesLabelText.textColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    self.minutesLabelText.highlightedTextColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    
    self.secondsLabelText.font = [UIFont fontWithName:@"Gotham-Light" size:27];
    self.secondsLabelText.textColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    self.secondsLabelText.highlightedTextColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    
    self.countdownText.font = [UIFont fontWithName:@"Gotham-Medium" size:13];
    self.countdownText.textColor = [UIColor colorWithRed:133/255.0 green:133/225.0 blue:133/255.0 alpha:1];
    self.countdownText.highlightedTextColor = [UIColor colorWithRed:133/255.0 green:133/225.0 blue:133/255.0 alpha:1];
    
    self.cityText.font = [UIFont fontWithName:@"Gotham-Medium" size:16];
    self.cityText.textColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];
    self.cityText.highlightedTextColor = [UIColor colorWithRed:35/255.0 green:101/225.0 blue:166/255.0 alpha:1];

}
@end
