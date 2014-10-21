//
//  LocationSpec.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/18/14.
//  Copyright 2014 Flatiron School. All rights reserved.
//

#ifdef ADVANCED
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "Location.h"


SpecBegin(Location)

describe(@"Location", ^{
    
    __block Location *location;
    
    beforeEach(^{
        
        location = [[Location alloc] init];
    });
    
    
    it(@"should have an address property", ^{
        expect(location).to.respondTo(@selector(address));
        expect(location).to.respondTo(@selector(setAddress:));
        
        location.address = @"11 Broadway";
        expect(location.address).to.beKindOf([NSString class]);
        expect(location.address).to.equal(@"11 Broadway");
    });  
    
    it(@"should have an city property", ^{
        expect(location).to.respondTo(@selector(city));
        expect(location).to.respondTo(@selector(setCity:));
        
        location.city = @"New York";
        expect(location.city).to.beKindOf([NSString class]);
        expect(location.city).to.equal(@"New York");
    });
    
    it(@"should have an state property", ^{
        expect(location).to.respondTo(@selector(state));
        expect(location).to.respondTo(@selector(setState:));
        
        location.state = @"New York";
        expect(location.state).to.beKindOf([NSString class]);
        expect(location.state).to.equal(@"New York");
    });
    
    it(@"should have an postalCode property", ^{
        expect(location).to.respondTo(@selector(postalCode));
        expect(location).to.respondTo(@selector(setPostalCode:));
        
        location.postalCode=@"10036";
        expect(location.postalCode).to.beKindOf([NSString class]);
        expect(location.postalCode).to.equal(@"10036");
    });
    
    it(@"should have an country property", ^{
        expect(location).to.respondTo(@selector(country));
        expect(location).to.respondTo(@selector(setCountry:));
        
        location.country = @"USA";
        expect(location.country).to.beKindOf([NSString class]);
        expect(location.country).to.equal(@"USA");
    });
    
    it(@"should have an crossStreet property", ^{
        expect(location).to.respondTo(@selector(crossStreet));
        expect(location).to.respondTo(@selector(setCrossStreet:));
        
        location.crossStreet = @"who knows";
        expect(location.crossStreet).to.beKindOf([NSString class]);
        expect(location.crossStreet).to.equal(@"who knows");
    });
    
    it(@"should have a default initializer", ^{
        
        expect(location.lat).to.equal(@0.0);
        expect(location.lng).to.equal(@0.0);
        expect(location.address).to.equal(@"");
        expect(location.city).to.equal(@"");
        expect(location.state).to.equal(@"");
        expect(location.country).to.equal(@"");
        expect(location.postalCode).to.equal(@"");
        expect(location.crossStreet).to.equal(@"");
        
    });
    
    it(@"should have a designated initializer", ^{
        
        //respond to method name?
        
        location = [[Location alloc] initWithlat:@40.0560 lng:@-74.0750 address:@"11 Broadway" city:@"New York" state:@"New York" postalCode:@"10036" country:@"USA" crossStreet:@"who really knows anyway"];
        
        expect(location.address).to.equal(@"11 Broadway");
        expect(location.city).to.equal(@"New York");
        expect(location.state).to.equal(@"New York");
        expect(location.country).to.equal(@"USA");
        expect(location.postalCode).to.equal(@"10036");
        expect(location.crossStreet).to.equal(@"who really knows anyway");
    });
    
    describe(@"creates location from locationDictionary", ^{

        it(@"should respond to initWithLocationDictionary ", ^{
            expect([Location class]).to.respondTo(@selector(locationWithLocationDictionary:));
        });
        
        it(@"should return the appropriate values", ^{
            
            NSDictionary *locationDictionary = @{@"address":@"11 Broadway",@"city":@"New York",@"state":@"New York",@"postalCode":@"10036",@"country":@"USA",@"crossStreet":@"who can tell"};
            
            location = [Location locationWithLocationDictionary:locationDictionary];
            
            expect(location.address).to.equal(@"11 Broadway");
            expect(location.city).to.equal(@"New York");
            expect(location.state).to.equal(@"New York");
            expect(location.country).to.equal(@"USA");
            expect(location.postalCode).to.equal(@"10036");
            expect(location.crossStreet).to.equal(@"who can tell");
        });
        
    });
    
});

SpecEnd
#endif
