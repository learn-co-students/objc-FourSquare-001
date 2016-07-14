//
//  Venue.m
//  objc-Foursquare
//
//  Created by Ken M. Haggerty on 2/23/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (instancetype)initWithName:(NSString *)name venueId:(NSString *)venueId location:(Location *)location
{
    self = [super init];
    if (self)
    {
        _name = name;
        _venueId = venueId;
        _location = location;
    }
    return self;
}

+ (NSArray *)venuesWithVenues:(NSArray *)venues
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:venues.count];
    for (NSDictionary *venueDictionary in venues)
    {
        [array addObject:[Venue venueWithVenueDictionary:venueDictionary]];
    }
    return array;
}

+ (instancetype)venueWithVenueDictionary:(NSDictionary *)venueDictionary
{
    if (!venueDictionary) return nil;
    
    return [[Venue alloc] initWithName:venueDictionary[@"name"] venueId:venueDictionary[@"id"] location:[Location locationWithLocationDictionary:venueDictionary[@"location"]]];
}

@end
