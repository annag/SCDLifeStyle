//
//  ChallengesViewController.m
//  SCDLifeStyle
//
//  Created by Anna Grueter on 5/20/12.
//  Copyright (c) 2012 reigndesign. All rights reserved.
//

#import "ChallengesViewController.h"
#import "Util.h"
#import "ChallengeCell.h"
#import "Challenge.h"
#import "ChallengeDetailViewController.h"
#import "Util.h"

@interface ChallengesViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *dataArray;


@end

@implementation ChallengesViewController

@synthesize tableView;
@synthesize dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[Util instance] updateChallenges];
    self.dataArray = [[Util instance] getChallenges];
    [self.tableView reloadData];

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ChallengeDetail"]) 
    {
        ChallengeDetailViewController *chdvc = [segue destinationViewController];
        chdvc.challenge = sender;
    }
}

#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Challenge *challenge = [self.dataArray objectAtIndex:indexPath.row];
    ChallengeCell *cell = (ChallengeCell*)[self.tableView dequeueReusableCellWithIdentifier:@"ChallengeCell"];
    cell.title.text = challenge.name;
    
    if (challenge.started.boolValue) 
    {
        if (challenge.finished.boolValue) 
        {
            cell.subTitle.text = @"Completed.";
        }
        else 
        {
            int daysRemaining = [[Util instance] getDaysRemainingForChallenge:challenge];
            cell.subTitle.text = [NSString stringWithFormat:@"Active: %d days to go.",daysRemaining];
        }

    }
    else 
    {
        cell.subTitle.text = @"Not Started.";
    }
    
    cell.tag = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Challenge *challenge = [self.dataArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ChallengeDetail" sender:challenge];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        Challenge *challenge = [self.dataArray objectAtIndex:indexPath.row];
        [self.managedObjectContext deleteObject:challenge];
        NSError *error = nil;
        [self.managedObjectContext save:&error];
        if (error != nil) {
            Alert(@"Challenge",@"Error deleting challenge");
        }
        self.dataArray = [[Util instance] getChallenges];
        [self.tableView reloadData];
    }    
}

@end
