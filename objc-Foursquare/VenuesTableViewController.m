//
//  FISTableViewController.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/17/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "VenuesTableViewController.h"
#import <Foursquare-API-v2/Foursquare2.h>

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
    
    [Foursquare2 venueSearchNearByLatitude:@40.7050
                                 longitude:@-74.0136
                                     query:@"Mexican"
                                     limit:@100 // We'll allow 100 results
                                    intent:intentBrowse
                                    radius:@1500
                                categoryId:nil
                                  callback:^(BOOL success, id result) {
                                      
                                      self.venues = [[NSMutableArray alloc] init];
                    
                                      for (NSDictionary *venue in result[@"response"][@"venues"] ) {
                                          [self.venues addObject:venue];
                                      }
                                      
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
    
    NSDictionary *venue = self.venues[indexPath.row];
    
    cell.textLabel.text = venue[@"name"];
    cell.detailTextLabel.text = [venue[@"stats"][@"checkinsCount"] stringValue];
    return cell;

}

@end
