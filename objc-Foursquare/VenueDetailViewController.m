//
//  VenueDetailViewController.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/18/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "VenueDetailViewController.h"
#import "Venue.h"
#import "Location.h"

@interface VenueDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *venueIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *postalCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *crossStreetLabel;

@end

@implementation VenueDetailViewController

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
    
    
    self.navigationItem.title = self.venue.name;
    self.venueIDLabel.text = self.venue.venueId;
    self.addressLabel.text = self.venue.location.address;
    self.cityLabel.text = self.venue.location.city;
    self.stateLabel.text = self.venue.location.state;
    self.postalCodeLabel.text = self.venue.location.postalCode;
    self.crossStreetLabel.text = self.venue.location.crossStreet;
    
    self.view.accessibilityLabel = @"VenueDetailView";
    self.venueIDLabel.accessibilityLabel = @"VenueIDLabel";
    self.addressLabel.accessibilityLabel = @"AddressLabel";
    self.cityLabel.accessibilityLabel = @"CityLabel";
    self.stateLabel.accessibilityLabel = @"StateLabel";
    self.postalCodeLabel.accessibilityLabel = @"PostalCodeLabel";
    self.crossStreetLabel.accessibilityLabel = @"CrossStreetLabel";
    
}

@end
