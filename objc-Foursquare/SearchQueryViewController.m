//
//  SearchQueryViewController.m
//  objc-Foursquare
//
//  Created by Ken M. Haggerty on 2/23/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "SearchQueryViewController.h"
#import "Foursquare2.h"
#import "VenuesTableViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SearchQueryViewController () <CLLocationManagerDelegate>
@property (nonatomic, strong) IBOutlet UITextField *search;
@property (nonatomic, strong) IBOutlet UITextField *distance;
@property (nonatomic, strong) IBOutlet UITextField *latitude;
@property (nonatomic, strong) IBOutlet UITextField *longitude;
@property (nonatomic, strong) NSArray <Venue *> *venues;
@property (nonatomic, strong) CLLocationManager *locationManager;
- (IBAction)search:(UIButton *)sender;
@end

@implementation SearchQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [self.locationManager setDelegate:self];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        NSUInteger code = [CLLocationManager authorizationStatus];
        
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            
            if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]) {
                [self.locationManager requestAlwaysAuthorization];
            }
            else if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            }
            else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    VenuesTableViewController *venuesTableViewController = (VenuesTableViewController *)segue.destinationViewController;
    [venuesTableViewController setVenues:self.venues];
}

- (IBAction)search:(UIButton *)sender
{
    [sender setTitle:@"Searching..." forState:UIControlStateDisabled];
    [sender setEnabled:NO];
    NSNumber *latitude = [NSNumber numberWithFloat:self.latitude.text.floatValue];
    NSNumber *longitude = [NSNumber numberWithFloat:self.longitude.text.floatValue];
    NSString *query = self.search.text;
    NSNumber *radius = [NSNumber numberWithFloat:self.distance.text.floatValue];
    [Foursquare2 venueSearchNearByLatitude:latitude longitude:longitude query:query limit:@100 intent:intentBrowse radius:radius categoryId:nil callback:^(BOOL success, id result) {
        
        [sender setEnabled:YES];
        
        if (!success)
        {
            NSLog(@"%@", result);
            return;
        }
        
        [self setVenues:[Venue venuesWithVenues:result[@"response"][@"venues"]]];
        [self performSegueWithIdentifier:@"segueVenues" sender:self];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray <CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    if (!self.latitude.text.length) [self.latitude setText:[NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude]];
    if (!self.longitude.text.length) [self.longitude setText:[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

@end
