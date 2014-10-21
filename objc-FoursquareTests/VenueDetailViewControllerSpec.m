//
//  VenueDetailViewControllerSpec.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/18/14.
//  Copyright 2014 Flatiron School. All rights reserved.
//

#ifdef ADVANCED
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "VenueDetailViewController.h"
#import "AppDelegate.h"
#import <KIF/KIF.h>
#import "Venue.h"
#import "Location.h"

SpecBegin(VenuesDetailViewController)

describe(@"VenueDetailViewController", ^{
    
    __block VenueDetailViewController *venueDVC;
    
    beforeAll(^{
       NSDictionary *locationDictionary = @{@"address":@"83 Pearl St", @"city":@"New York",@"state":@"New York", @"postalCode":@"10004", @"country":@"USA", @"crossStreet":@"at Stone St."};
       NSDictionary *venueDictionary = @{@"name":@"Mad Dog & Beans Mexican Cantina",@"venueId":@"4a15a2e8f964a520a9781fe3",@"location":locationDictionary};
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        venueDVC = (VenueDetailViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"VenueDVC"];
        
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = venueDVC;
        
        venueDVC.venue = [Venue venueWithVenueDictionary:venueDictionary];
    });
    
    describe(@"UILabels", ^{

    it(@"should show the correct venue Id in a label", ^{
       UILabel *venueIdLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"VenueIDLabel"];
        venueIdLabel.text = venueDVC.venue.venueId;
        expect(venueIdLabel).toNot.beNil();
        expect(venueIdLabel.text).to.equal(venueDVC.venue.venueId);
    });
    
    it(@"should show the address in a label", ^{
        UILabel *addressLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"AddressLabel"];
        addressLabel.text = venueDVC.venue.location.address;
        expect(addressLabel).toNot.beNil();
        expect(addressLabel.text).to.equal(venueDVC.venue.location.address);
    });
    
    it(@"should show the city in a label", ^{
        UILabel *cityLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"CityLabel"];
        cityLabel.text = venueDVC.venue.location.city;
        expect(cityLabel).toNot.beNil();
        expect(cityLabel.text).to.equal(venueDVC.venue.location.city);
    });
    
    it(@"should show the state in a label", ^{
        UILabel *stateLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"StateLabel"];
        stateLabel.text = venueDVC.venue.location.state;
        expect(stateLabel).toNot.beNil();
        expect(stateLabel.text).to.equal(venueDVC.venue.location.state);
    });
    
    it(@"should show the postalCode in a label", ^{
        UILabel *postalCodeLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"PostalCodeLabel"];
        postalCodeLabel.text = venueDVC.venue.location.postalCode;
        expect(postalCodeLabel).toNot.beNil();
        expect(postalCodeLabel.text).to.equal(venueDVC.venue.location.postalCode);
    });
    
    it(@"should show the cross street in a label", ^{
        UILabel *crossStreetLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"CrossStreetLabel"];
        crossStreetLabel.text = venueDVC.venue.location.crossStreet;
        expect(crossStreetLabel).toNot.beNil();
        expect(crossStreetLabel.text).to.equal(venueDVC.venue.location.crossStreet);
    });
        
    });
});

SpecEnd
#endif