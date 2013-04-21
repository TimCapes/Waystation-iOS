//
//  RightController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RightController.h"
#import "SAWAppDelegate.h"
#import "SAWWaystationViewController.h"
#import "PhotoViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@implementation RightController

@synthesize tableView=_tableView;

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    pan.delegate = (id<UIGestureRecognizerDelegate>)self;
//    [self.view addGestureRecognizer:pan];
//    _pan = pan;

    if (!_tableView) {
        
        CGRect frame = self.view.bounds;
        frame.origin.x = 80.0f;
        frame.size.width -= 80.0f;
    
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        [self.view addSubview:tableView];
        self.tableView = tableView;        
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

#pragma mark - Temporary Hack Gesture
//
//- (void)pan:(UIPanGestureRecognizer*)gesture {
//    [self.root showRootController:YES];
//}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row==0){
       cell.textLabel.text = [NSString stringWithFormat:@"Photo Booth"]; 
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"A little birdy told me"];
    }
    return cell;
    
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Right Controller";
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        NSLog(@"Got here");
        UINavigationController *menuController = (UINavigationController*)((SAWAppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        PhotoViewController *nextViewController =[[[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil] autorelease];
        [menuController pushViewController: nextViewController animated:YES];
    } else {
        [self sendEasyTweet];
    }

//    // lets just push another feed view 
//    UINavigationController *menuController = (UINavigationController *)((SAAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
//    FeedController *controller = [[FeedController alloc] init];
//    [menuController pushViewController:controller animated:YES];
}
# pragma mark - Tweeting
- (IBAction)sendEasyTweet {
    // Set up the built-in twitter composition view controller.
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
    // Set the initial tweet text. See the framework for additional properties that can be set.
    [tweetViewController setInitialText:@"At the NASA Hackathon tweeting from in App."];
    
    // Create the completion handler block.
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        NSString *output;
        
        switch (result) {
            case TWTweetComposeViewControllerResultCancelled:
                // The cancel button was tapped.
                output = @"Tweet cancelled.";
                [self postToAPI];
                break;
                //NSError *error;
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

- (void)displayText:(NSString *)text {
	//self.outputTextView.text = text;
}

@end