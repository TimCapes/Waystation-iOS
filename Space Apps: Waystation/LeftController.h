//
//  LeftController.h
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"

@interface LeftController : UIViewController <DDMenuControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,retain) DDMenuController *root;
@property(nonatomic,readonly) UIPanGestureRecognizer *pan;
@end
