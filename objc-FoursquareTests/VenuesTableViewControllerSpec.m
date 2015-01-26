//
//  VenuesTableViewControllerSpec.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/17/14.
//  Copyright 2014 Flatiron School. All rights reserved.
//

#ifndef ADVANCED
#import "Specta.h"

#define EXP_SHORTHAND
#import "Expecta.h"
#import "VenuesTableViewController.h"
#import "AppDelegate.h"
#import <KIF/KIF.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

SpecBegin(VenuesTableViewController)

describe(@"VenuesTableViewController", ^{
    
    __block NSData *testData;
    __block VenuesTableViewController *venuesTVC;
    __block UITableView *tableView;
    __block NSIndexPath *ip;
    __block UITableViewCell *firstCell;
    
    beforeAll(^{
       
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        venuesTVC = (VenuesTableViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"VenuesTVC"];
                
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = venuesTVC;
      
        NSString *test = OHPathForFileInBundle(@"foursquareResultsStub.json", nil);
        
        NSData * responseData = [NSData dataWithContentsOfFile:test];
        NSError * error=nil;
        NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
            
        NSArray *venuesArray = jsonDictionary[@"response"][@"venues"];
        testData = [NSJSONSerialization dataWithJSONObject:venuesArray options:0 error:nil];
       // testData = [NSKeyedArchiver archivedDataWithRootObject:venuesArray];
        
        
        tableView = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"VenuesTableView"];
        ip = [NSIndexPath indexPathForRow:0 inSection:0];
        firstCell = [tester waitForCellAtIndexPath:ip inTableViewWithAccessibilityIdentifier:@"VenuesTableView"];


    });
    
    it(@"should have a venues array property", ^{
        expect(venuesTVC).to.respondTo(@selector(venues));
        expect(venuesTVC).to.respondTo(@selector(setVenues:));
    });
    
    describe(@"TableView", ^{
        it(@"Should have 1 section", ^{
            expect([tableView numberOfSections]).to.equal(1);
        });
        
        it(@"Should have fourteen cells", ^{
            expect([tableView numberOfRowsInSection:0]).to.equal(1);
        });
    });
    
    describe(@"TableView Cells", ^{
        it(@"Should have a textLabel", ^{
            expect(firstCell.textLabel).toNot.beNil();
        });
        
        it(@"Should have the correct cells", ^{
            expect(firstCell.textLabel.text).to.equal(@"Mad Dog & Beans Mexican Cantina");
        });
        
        it(@"Should have a detailTextLabel", ^{
            expect(firstCell.textLabel).toNot.beNil();
        });
        
        it(@"Should have the correct text in the detailTextLabel", ^{
            expect(firstCell.detailTextLabel.text).to.equal(@"15799");
        });
        
    });
    
    describe(@"viewDidLoad", ^{
        
        it(@"successfully returns data", ^{
            [venuesTVC viewDidLoad];
            
            //Comparing binary version of venue download vs. what we have cached.
            NSData *venueData = [NSJSONSerialization dataWithJSONObject:venuesTVC.venues options:0 error:nil];
        
            expect(venueData).to.equal(testData);
        });
        
    });
});

SpecEnd
#endif
