//
//  SAWPhotoDemoViewController.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-21.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWPhotoViewController.h"
#import "OverlayViewController.h"

@interface SAWPhotoViewController ()
@property (nonatomic, retain) OverlayViewController *overlayViewController;

@property (nonatomic, retain) NSMutableArray *capturedImages;
@end

@implementation SAWPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.overlayViewController =
    [[[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil] autorelease];
    
    // as a delegate we will be notified when pictures are taken and when to dismiss the image picker
    self.overlayViewController.delegate = self;
    self.nameBox.delegate = self;
    self.messageBox.delegate = self;
    
    self.capturedImages = [NSMutableArray array];
    
}
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)photoLibraryAction:(id)sender
{
	[self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (IBAction)back:(id)sender {
    [self screen1];
}

- (IBAction)cameraAction:(id)sender
{
    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
}

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    if (self.imageView.isAnimating)
        [self.imageView stopAnimating];
	
    if (self.capturedImages.count > 0)
        [self.capturedImages removeAllObjects];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        [self.overlayViewController setupImagePicker:sourceType];
        [self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
    }
}

- (void)didTakePicture:(UIImage *)picture
{
    [self.capturedImages addObject:picture];
}

- (void)didFinishWithCamera
{
    [self dismissModalViewControllerAnimated:YES];
    
    if ([self.capturedImages count] > 0)
    {
        if ([self.capturedImages count] == 1)
        {
            // we took a single shot
            [self.imageView setImage:[self.capturedImages objectAtIndex:0]];
            [self screen2];
        }
        else
        {
            // we took multiple shots, use the list of images for animation
            self.imageView.animationImages = self.capturedImages;
            
            if (self.capturedImages.count > 0)
                // we are done with the image list until next time
                [self.capturedImages removeAllObjects];
            
            self.imageView.animationDuration = 5.0;    // show each captured photo for 5 seconds
            self.imageView.animationRepeatCount = 0;   // animate forever (show all photos)
            [self.imageView startAnimating];
        }
    }
}
- (void) screen2 {
    
    self.rushedBackground.image = [UIImage imageNamed:@"_capture2.png"];
    [self.scrollView bringSubviewToFront: self.imageView];
    [self.scrollView bringSubviewToFront: self.backButton];
    [self.scrollView bringSubviewToFront: self.messageBox];
    [self.scrollView bringSubviewToFront: self.nameBox];
    [self.scrollView bringSubviewToFront: self.sendButton];
    [self.scrollView sendSubviewToBack: self.cameraAction];
    [self.scrollView bringSubviewToFront: self.closeButton];
}

- (void) screen1 {
    self.rushedBackground.image = [UIImage imageNamed:@"_capture1.png"];
    [self.scrollView sendSubviewToBack: self.imageView];
    [self.scrollView sendSubviewToBack: self.backButton];
    [self.scrollView sendSubviewToBack: self.messageBox];
    [self.scrollView sendSubviewToBack: self.nameBox];
    [self.scrollView sendSubviewToBack: self.sendButton];
    [self.scrollView bringSubviewToFront: self.closeButton];
    [self.scrollView bringSubviewToFront: self.cameraAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageView release];
    [_rushedBackground release]; 
    [_cameraAction release];
    [_closeButton release];
    [_backButton release];
    [_messageBox release];
    [_nameBox release];
    [_sendButton release];
    [_scrollView release];
    [super dealloc];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    if (textField == self.nameBox) {
        // Found next responder, so set it.
        [self.messageBox becomeFirstResponder];
        //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1+error1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES]; 
       }else{
        
        self.scrollView.contentInset =UIEdgeInsetsMake(0,0,0,0);
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    self.scrollView.contentInset = UIEdgeInsetsMake(0,0,235,0);
    
    if (textField == self.nameBox) {
        [self.scrollView scrollRectToVisible:self.messageBox.frame animated:YES];
    }else{
        [self.scrollView scrollRectToVisible:self.sendButton.frame animated:YES];
    }
    
}

@end
