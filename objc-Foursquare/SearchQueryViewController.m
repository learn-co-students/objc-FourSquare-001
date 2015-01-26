//
//  SearchQueryViewController.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/18/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "SearchQueryViewController.h"
#import "VenuesTableViewController.h"

@interface SearchQueryViewController ()

@property (strong, nonatomic) IBOutlet UITextField *queryField;
@property (strong, nonatomic) IBOutlet UITextField *willingnessToTravelField;
@property (strong, nonatomic) IBOutlet UITextField *latitudeField;
@property (strong, nonatomic) IBOutlet UITextField *longitudeField;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation SearchQueryViewController

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
    
    self.queryField.accessibilityLabel = @"QueryField";
    self.willingnessToTravelField.accessibilityLabel = @"WillingnessToTravelField";
    self.latitudeField.accessibilityLabel = @"LatitudeField";
    self.longitudeField.accessibilityLabel = @"LongitudeField";
    self.searchButton.accessibilityLabel = @"SearchButton";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    VenuesTableViewController *venuesTVC = [segue destinationViewController];
    
    venuesTVC.queryString = self.queryField.text;
    
    NSString *distance = self.willingnessToTravelField.text;
    venuesTVC.radiusDistance = @([distance floatValue]);
    
    NSString *lat = self.latitudeField.text;
    venuesTVC.currentLatitude = @([lat floatValue]);
    
    NSString *lng = self.longitudeField.text;
    venuesTVC.currentLongitude = @([lng floatValue]);
}

@end
