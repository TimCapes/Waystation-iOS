//
//  SAWPhotoDemoViewController.h
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-21.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAWPhotoViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIImageView *rushedBackground;
@property (retain, nonatomic) IBOutlet UIButton *cameraAction;
@property (retain, nonatomic) IBOutlet UIButton *closeButton;
@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UITextField *messageBox;
@property (retain, nonatomic) IBOutlet UITextField *nameBox;
@property (retain, nonatomic) IBOutlet UIButton *sendButton;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end
