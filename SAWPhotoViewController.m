//
//  SAWPhotoDemoViewController.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-21.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWPhotoViewController.h"
#import "OverlayViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "SAWAppDelegate.h"
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

- (void) displayText: (NSString *) output{
    [self postToAPI];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sendTweet:(id)sender {
    NSLog(@"SendTweet Called");
    SAWAppDelegate *appDelegate = (SAWAppDelegate *)[[UIApplication sharedApplication] delegate];
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    NSMutableString *stringToAppend = [NSMutableString stringWithFormat: @" (via @waystationapp) from "];
    [stringToAppend appendString:[appDelegate.dataForTweet objectForKey:@"city"]];
    [stringToAppend appendString:@" into orbit for @Cmdr_Hadfield"];

    // Set the initial tweet text. See the framework for additional properties that can be set.
    [tweetViewController setInitialText:[self.messageBox.text stringByAppendingString:stringToAppend]];
    [tweetViewController addImage:self.imageView.image];
    // Create the completion handler block.
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        NSString *output;
        
        switch (result) {
            case TWTweetComposeViewControllerResultCancelled:
                // The cancel button was tapped.
                output = @"Tweet cancelled.";
                break;
            case TWTweetComposeViewControllerResultDone:
                // The tweet was sent.
                output = @"Tweet done.";
                break;
            default:
                break;
        }
        
        [self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
        
        // Dismiss the tweet composition view controller.
        [self dismissModalViewControllerAnimated:YES];
    }];
    
    // Present the tweet composition view controller modally.
    [self presentModalViewController:tweetViewController animated:YES];
}

        // Create an account store object.
//        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
//        
//        // Create an account type that ensures Twitter accounts are retrieved.
//        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//        
//        // Request access from the user to use their Twitter accounts.
//        [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
//            if(granted) {
//                // Get the list of Twitter accounts.
//                NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
//                
//                // For the sake of brevity, we'll assume there is only one Twitter account present.
//                // You would ideally ask the user which account they want to tweet from, if there is more than one Twitter account present.
//                if ([accountsArray count] > 0) {
//                    // Grab the initial Twitter account to tweet from.
//                    ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
//                    //TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"https://upload.twitter.com/1/statuses/update_with_media.json"] parameters:nil requestMethod:TWRequestMethodPOST];
//                    TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"] parameters:[NSDictionary dictionaryWithObject:self.messageBox.text forKey:@"status"] requestMethod:TWRequestMethodPOST];
//                    UIImage * image = self.imageView.image;
//                    //[postRequest a]
//                     //[postRequest addMultiPartData:UIImagePNGRepresentation(image) withName:@"media" type:@"multipart/form-data"];
//                    //add text
//                    //[postRequest addMultiPartData:[self.messageBox.text dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data"];
//                    
//                    [postRequest setAccount:twitterAccount];
//                    
//                    // Perform the request created above and create a handler block to handle the response.
//                    [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                        NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
//                        NSLog(@"twitter response");
//                        NSLog(output);
//                        [self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
//                        
//                    }];
//                }
//            }
//        }];
//    }
- (void) tweetResult: (NSString *)output {
    [self postToAPI];
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
   // [self.scrollView bringSubviewToFront: self.nameBox];
    [self.scrollView bringSubviewToFront: self.sendButton];
    [self.scrollView sendSubviewToBack: self.cameraAction];
    [self.scrollView bringSubviewToFront: self.closeButton];
}

- (void) screen1 {
    self.rushedBackground.image = [UIImage imageNamed:@"_capture1.png"];
    [self.scrollView sendSubviewToBack: self.imageView];
    [self.scrollView sendSubviewToBack: self.backButton];
    [self.scrollView sendSubviewToBack: self.messageBox];
   // [self.scrollView sendSubviewToBack: self.nameBox];
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

- (void) postToAPI {
    SAWAppDelegate *appDelegate = (SAWAppDelegate *)[[UIApplication sharedApplication] delegate];
    //NSMutableDictionary *myDictionary= [appDelegate.waystation addressForSending];
    self.myData =[[[NSMutableData alloc] init] autorelease];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:appDelegate.dataForTweet
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    //    if (! jsonData) {
    //        NSLog(@"Got an error: %@", error);
    //    } else {
    NSString *jsonPayload = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // } //appDelegate.dataForTweet options:NSJSONWritingPrettyPrinted error:&error];
    NSLog (@"%@",appDelegate.dataForTweet);
    NSLog (@"%@",jsonPayload);
    NSURL *url = [NSURL URLWithString:@"http://waystation-api.herokuapp.com/sightings"];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *escapedDataString = [jsonPayload stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [request setValue:[NSString stringWithFormat:@"%d", [escapedDataString length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:[escapedDataString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    //[request setHTTPBody: jsonData];
    self.myConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.myData appendData:data];
    NSLog(@"Recieved Data");
}

- (void) connection: (NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response {
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSLog(@"Got here");
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        int code = [httpResponse statusCode];
        NSLog(@"%d",code);
        //If you need the response, you can use it here
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(finishLoading) userInfo:nil repeats:NO];
    NSLog(@"Responses Finished");
    //NSLog(self.myData);
}

@end
