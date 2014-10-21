//
//  VenuesTableViewControllerAdvancedSpec.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/18/14.
//  Copyright 2014 Flatiron School. All rights reserved.
//

#ifdef ADVANCED
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "VenuesTableViewController.h"
#import "AppDelegate.h"
#import <KIF/KIF.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

SpecBegin(VenuesTableViewController)

describe(@"VenuesAdvancedTableViewController", ^{
    
    __block VenuesTableViewController *venuesTVC;
    __block UITableView *tableView;
    __block NSIndexPath *ip;
    __block UITableViewCell *firstCell;
    
    beforeAll(^{

        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        venuesTVC = (VenuesTableViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"VenuesTVC"];
        
        UINavigationController *navController = [[UINavigationController alloc] init];
        
        navController.viewControllers = [NSArray arrayWithObject:venuesTVC];
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = navController;
        
        tableView = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"VenuesTableView"];
        ip = [NSIndexPath indexPathForRow:0 inSection:0];
        firstCell = [tester waitForCellAtIndexPath:ip inTableViewWithAccessibilityIdentifier:@"VenuesTableView"];
        
    });
    
    describe(@"TableView Cells", ^{
        it(@"Should have a textLabel", ^{
            expect(firstCell.textLabel).toNot.beNil();
        });
        
        it(@"Should have the correct cells", ^{
            expect(firstCell.textLabel.text).to.equal(@"Mad Dog & Beans Mexican Cantina");
        });
    });
    
    describe(@"selectedRow", ^{
        it(@"should segue to the detail view controller", ^{
            [tester tapRowAtIndexPath:ip inTableViewWithAccessibilityIdentifier:@"VenuesTableView"];
            [tester waitForViewWithAccessibilityLabel:@"VenueDetailView"];
        });
    });


});

SpecEnd
#endif
