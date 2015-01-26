//
//  Location.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/17/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)init
{
    return [self initWithlat:@0.0000 lng:@0.0000 address:@"" city:@"" state:@"" postalCode:@"" country:@"" crossStreet:@""];
}

- (instancetype)initWithlat:(NSNumber *)lat
                        lng:(NSNumber *)lng
                    address:(NSString *)address
                       city:(NSString *)city
                      state:(NSString *)state
                 postalCode:(NSString *)postalCode
                    country:(NSString *)country
                crossStreet:(NSString *)crossStreet
{
    self = [super init];
    
    if (self)
    {
        _lat = lat;
        _lng = lng;
        _address = address;
        _city = city;
        _state = state;
        _postalCode = postalCode;
        _country = country;
        _crossStreet = crossStreet;
    }
    
    return self;
}

+ (instancetype)locationWithLocationDictionary:(NSDictionary *)locationDictionary
{
    Location *location = [[Location alloc] initWithlat:locationDictionary[@"lat"] lng:locationDictionary[@"lng"] address:locationDictionary[@"address"] city:locationDictionary[@"city"] state:locationDictionary[@"state"] postalCode:locationDictionary[@"postalCode"] country:locationDictionary[@"country"] crossStreet:locationDictionary[@"crossStreet"]];
    
    return location;
}

@end
