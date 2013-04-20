//
//  RightController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RightController.h"
#import "SAWAppDelegate.h"
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

- (void)displayText:(NSString *)text {
	//self.outputTextView.text = text;
}

@end