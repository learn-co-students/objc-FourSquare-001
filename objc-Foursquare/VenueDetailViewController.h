//
//  VenueDetailViewController.h
//  objc-Foursquare
//
//  Created by Ken M. Haggerty on 2/23/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Venue.h"

@interface VenueDetailViewController : UIViewController
@property (nonatomic, strong) Venue *venue;
@end
