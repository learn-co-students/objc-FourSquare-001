//
//  VenueSpec.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/18/14.
//  Copyright 2014 Flatiron School. All rights reserved.
//

#ifdef ADVANCED
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "Venue.h"
#import "Location.h"
#import "Swizzlean.h"

SpecBegin(Venue)

describe(@"Venue", ^{
    
    __block Venue *venue;
    __block NSArray *venues;
    beforeAll(^{

    });
    
    beforeEach(^{
        venues = [[NSArray alloc] init];
        venue=[[Venue alloc] init];
    });
    
    
    it(@"should have an name property ", ^{
        expect(venue).to.respondTo(@selector(name));
        expect(venue).to.respondTo(@selector(setName:));
        
        venue.name=@"Name";
        expect(venue.name).to.beKindOf([NSString class]);
        expect(venue.name).to.equal(@"Name");
    });
    
    it(@"should have a venueId property ", ^{
        expect(venue).to.respondTo(@selector(venueId));
        expect(venue).to.respondTo(@selector(setVenueId:));
        
        venue.venueId=@"Id";
        expect(venue.venueId).to.beKindOf([NSString class]);
        expect(venue.venueId).to.equal(@"Id");
    });
    
    it(@"should have a location property ", ^{
        expect(venue).to.respondTo(@selector(location));
        expect(venue).to.respondTo(@selector(setLocation:));
    });
    
    
    describe(@"should have a designated initializer", ^{
        
        it(@"should respond to initWithName:venueId:location:", ^{
            expect(venue).to.respondTo(@selector(initWithName:venueId:location:));
            
        });
        
        it(@"should return appropriate values", ^{
            Venue *venue = [[Venue alloc] init];
            
            expect(venue.name).to.equal(@"");
            expect(venue.venueId).to.equal(@"");
        });
        
    });
    
    describe(@"creates venue from venueDictionary", ^{

        __block NSDictionary *venueDictionary;
        __block NSDictionary *locationDictionary;
        beforeEach(^{
            locationDictionary = @{@"address":@"83 Pearl St", @"city":@"New York",@"state":@"New York", @"postalCode":@"10004", @"country":@"USA", @"crossStreet":@"at Stone St."};
            venueDictionary = @{@"name":@"Mad Dog & Beans Mexican Cantina",@"venueId":@"4a15a2e8f964a520a9781fe3",@"location":locationDictionary};
                
            });
        
        
        it(@"should respond to venueWithVenueDictionary ", ^{
            expect([Venue class]).to.respondTo(@selector(venueWithVenueDictionary:));
        });
        
        it(@"should have the appropriate values", ^{
            
            Swizzlean *swizzle = [[Swizzlean alloc] initWithClassToSwizzle:[Location class]];
                [swizzle swizzleClassMethod:@selector(locationWithLocationDictionary:) withReplacementImplementation:^(id _self, NSDictionary *passedInDict) {
                    
                    expect(passedInDict).to.equal(locationDictionary);
                    return nil;
                }];
            
            venue = [Venue venueWithVenueDictionary:venueDictionary];
            
            expect(venue.name).to.equal(@"Mad Dog & Beans Mexican Cantina");
            expect(venue.venueId).to.equal(@"4a15a2e8f964a520a9781fe3");
            
        });
        
    });

    describe(@"creates venues from venueDictionaries", ^{
        
        __block NSDictionary *venueDictionary;
        __block NSDictionary *locationDictionary;
        beforeAll(^{
            locationDictionary = @{@"address":@"83 Pearl St", @"city":@"New York",@"state":@"New York", @"postalCode":@"10004", @"country":@"USA", @"crossStreet":@"at Stone St."};
            venueDictionary = @{@"name":@"Mad Dog & Beans Mexican Cantina",@"venueId":@"4a15a2e8f964a520a9781fe3",@"location":locationDictionary};
            
        });
        
        it(@"should respond to venueWithVenueDictionary ", ^{
            expect([Venue class]).to.respondTo(@selector(venuesWithVenueDictionaries:));
        });
        
        it(@"should create multiple venues with appropriate values", ^{
           
            venues = [Venue venuesWithVenueDictionaries:@[venueDictionary]];
            
            Venue *venueDictionary = venues[0];
            
            expect(venueDictionary.name).to.equal(@"Mad Dog & Beans Mexican Cantina");
            expect(venueDictionary.venueId).to.equal(@"4a15a2e8f964a520a9781fe3");
            
            
        });
    });
    
});

SpecEnd
#endif