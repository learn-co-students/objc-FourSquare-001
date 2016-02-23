//
//  VenuesTableViewController.h
//  objc-Foursquare
//
//  Created by Ken M. Haggerty on 2/22/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenuesTableViewController : UITableViewController
@property (nonatomic, strong) NSArray <NSDictionary *> *venues;
@end
