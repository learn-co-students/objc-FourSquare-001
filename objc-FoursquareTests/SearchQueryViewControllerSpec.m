//
//  SearchQueryViewControllerSpec.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/18/14.
//  Copyright 2014 Flatiron School. All rights reserved.
//

#ifdef ADVANCED
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "SearchQueryViewController.h"
#import "AppDelegate.h"
#import <KIF/KIF.h>

SpecBegin(SearchQueryViewController)

describe(@"SearchQueryViewController", ^{
    
    describe(@"UILabels", ^{
        
        it(@"should contain a latitude text field", ^{
            [tester waitForViewWithAccessibilityLabel:@"LatitudeField"];
        });
        
        it(@"should contain a longitude text field", ^{
            [tester waitForViewWithAccessibilityLabel:@"LongitudeField"];

        });
        
        it(@"should contain a willingness to travel text field", ^{
            [tester waitForViewWithAccessibilityLabel:@"WillingnessToTravelField"];
        });
        
        it(@"should contain a query text field", ^{
            [tester waitForViewWithAccessibilityLabel:@"QueryField"];
        });
        
    });
    
    describe(@"searchButton", ^{
//        it(@"should segue to the results view controller", ^{
//            [tester tapViewWithAccessibilityLabel:@"SearchButton"];
//            [tester waitForViewWithAccessibilityLabel:@"VenuesTableView"];
//        });
//        
        
    });
    
});

SpecEnd
#endif