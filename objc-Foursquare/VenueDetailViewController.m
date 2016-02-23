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
@property (nonatomic, strong) IBOutlet UILabel *venueIDLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *cityLabel;
@property (nonatomic, strong) IBOutlet UILabel *stateLabel;
@property (nonatomic, strong) IBOutlet UILabel *postalCodeLabel;
@property (nonatomic, strong) IBOutlet UILabel *crossStreetLabel;
@end

@implementation VenueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.venueIDLabel setText:self.venue.venueId];
    [self.addressLabel setText:self.venue.location.address];
    [self.cityLabel setText:self.venue.location.city];
    [self.stateLabel setText:self.venue.location.state];
    [self.postalCodeLabel setText:self.venue.location.postalCode];
    [self.crossStreetLabel setText:self.venue.location.crossStreet];
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
