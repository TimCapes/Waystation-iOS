//
//  SAWTimingViewController.m
//  Space Apps: Waystation
//
//  Created by Tim Capes on 2013-04-21.
//  Copyright (c) 2013 SpaceApps. All rights reserved.
//

#import "SAWTimingViewController.h"
#import "SAWPhotoViewController.h"
#import "SAWAppDelegate.h"
#import "SAWCountdownCell.h"
#import "SAWStationPassCell.h"

@interface SAWTimingViewController ()
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SAWTimingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)spotTheSpaceStation:(id)sender {
    NSLog(@"Spot the station called");
    [self.navigationController pushViewController:[[[SAWPhotoViewController alloc]initWithNibName:@"SAWPhotoViewController" bundle:nil]autorelease] animated:YES];
}
- (IBAction)left:(id)sender {
    
    NSLog(@"Got Here");
    SAWAppDelegate *appDelegate = (SAWAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.menuController showLeftController:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_spot release];
    [_menuButton release];
    [_tableView release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        SAWCountdownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SAWCountdownCell"];
        if (!cell) {
            NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"SAWCountdownCell" owner:self options:nil];
            cell = [cellArray objectAtIndex: 0];
        }
        [cell setup];

        return cell;
    } else {
        SAWStationPassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SAWStationPassCell"];
        if (!cell) {
            NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"SAWStationPassCell" owner:self options:nil];
            cell = [cellArray objectAtIndex: 0];
        }
        [cell setup];
        if (indexPath.row > 2) {
            cell.timeText.text =@"11:59";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row==0){
        return 95;
    } else {
        return 120;
    }
}
- (NSString *)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
@end
