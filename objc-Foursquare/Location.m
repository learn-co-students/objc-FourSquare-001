//
//  Location.m
//  objc-Foursquare
//
//  Created by Ken M. Haggerty on 2/23/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)initWithlat:(NSNumber *)lat lng:(NSNumber *)lng address:(NSString *)address city:(NSString *)city state:(NSString *)state postalCode:(NSString *)postalCode country:(NSString *)country crossStreet:(NSString *)crossStreet
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

+ (NSArray *)locationsWithLocations:(NSArray *)locations
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:locations.count];
    for (NSDictionary *locationDictionary in locations)
    {
        [array addObject:[Location locationWithLocationDictionary:locationDictionary]];
    }
    return array;
}

+ (instancetype)locationWithLocationDictionary:(NSDictionary *)locationDictionary
{
    if (!locationDictionary) return nil;
    
    return [[Location alloc] initWithlat:locationDictionary[@"lat"] lng:locationDictionary[@"lng"] address:locationDictionary[@"address"] city:locationDictionary[@"city"] state:locationDictionary[@"state"] postalCode:locationDictionary[@"postalCode"] country:locationDictionary[@"country"] crossStreet:locationDictionary[@"crossStreet"]];
}

@end
