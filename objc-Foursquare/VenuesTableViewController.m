//
//  FISTableViewController.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/17/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "VenuesTableViewController.h"
#import <Foursquare-API-v2/Foursquare2.h>
#import "Venue.h"
#import "Location.h"
#import "VenueDetailViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface VenuesTableViewController ()


@end

@implementation VenuesTableViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.tableView.accessibilityLabel = @"VenuesTableView";
    self.tableView.accessibilityIdentifier = @"VenuesTableView";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [Foursquare2 venueSearchNearByLatitude:self.currentLatitude
                                 longitude:self.currentLongitude
                                     query:self.queryString
                                     limit:@100 // We'll allow 100 results
                                    intent:intentBrowse
                                    radius:self.radiusDistance
                                categoryId:nil
                                  callback:^(BOOL success, id result) {
                                      
                                      [SVProgressHUD dismiss];
                                      
                                      self.venues = [[NSMutableArray alloc] init];
                                      
                                      [self.venues addObjectsFromArray:[Venue venuesWithVenueDictionaries:result[@"response"][@"venues"]]];
                                      
                                      [self.tableView reloadData];
                                  }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venues count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell" forIndexPath:indexPath];
    
    Venue *venue = self.venues[indexPath.row];
    
    cell.textLabel.text = venue.name;
    return cell;

}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    VenueDetailViewController *venuesDetailViewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    venuesDetailViewController.venue = self.venues[indexPath.row];
    
}

@end
