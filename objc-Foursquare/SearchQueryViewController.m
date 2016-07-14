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
#import "SVProgressHUD.h"

@interface SearchQueryViewController () <CLLocationManagerDelegate>
@property (nonatomic, strong) IBOutlet UITextField *queryField;
@property (nonatomic, strong) IBOutlet UITextField *willingnessToTravelField;
@property (nonatomic, strong) IBOutlet UITextField *latitudeField;
@property (nonatomic, strong) IBOutlet UITextField *longitudeField;
@property (nonatomic, strong) IBOutlet UIButton *searchButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray <Venue *> *venues;
@property (nonatomic, strong) CLLocation *currentLocation;
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

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray <CLLocation *> *)locations
{
    [self setCurrentLocation:[locations lastObject]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (IBAction)search:(id)sender
{
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSNumber *latitude = (self.latitudeField.text.length ? [NSNumber numberWithFloat:self.latitudeField.text.floatValue] : [NSNumber numberWithFloat:self.currentLocation.coordinate.latitude]);
        NSNumber *longitude = (self.longitudeField.text.length ? [NSNumber numberWithFloat:self.longitudeField.text.floatValue] : [NSNumber numberWithFloat:self.currentLocation.coordinate.longitude]);
        NSString *query = self.queryField.text;
        NSNumber *radius = [NSNumber numberWithFloat:self.willingnessToTravelField.text.floatValue];
        
        [Foursquare2 venueSearchNearByLatitude:latitude longitude:longitude query:query limit:@100 intent:intentBrowse radius:radius categoryId:nil callback:^(BOOL success, id result) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
                if (!success)
                {
                    NSLog(@"%@", result);
                    return;
                }
                
                [self setVenues:[Venue venuesWithVenues:result[@"response"][@"venues"]]];
                [self performSegueWithIdentifier:@"segueVenues" sender:self];
            });
        }];
    });
}

@end
