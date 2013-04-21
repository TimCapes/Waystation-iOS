//
//  SAWFullScreenCell.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-21.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWFullScreenCell.h"

@implementation SAWFullScreenCell

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
    [_backgroundImage release];
    [_homeButton release];
    [_schedule release];
    [_notifcations release];
    [_settings release];
    [super dealloc];
}
@end
