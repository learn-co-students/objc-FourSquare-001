//
//  VenueDetailViewController.m
//  objc-Foursquare
//
//  Created by Ken M. Haggerty on 2/23/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "VenueDetailViewController.h"
#import "Location.h"

@interface VenueDetailViewController ()
@property (nonatomic, strong) IBOutlet UILabel *venueID;
@property (nonatomic, strong) IBOutlet UILabel *address;
@property (nonatomic, strong) IBOutlet UILabel *city;
@property (nonatomic, strong) IBOutlet UILabel *state;
@property (nonatomic, strong) IBOutlet UILabel *postalCode;
@property (nonatomic, strong) IBOutlet UILabel *crossStreet;
@end

@implementation VenueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.venueID setText:self.venue.venueId];
    [self.address setText:self.venue.location.address];
    [self.city setText:self.venue.location.city];
    [self.state setText:self.venue.location.state];
    [self.postalCode setText:self.venue.location.postalCode];
    [self.crossStreet setText:self.venue.location.crossStreet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
