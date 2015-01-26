//
//  Venue.m
//  FourSquare
//
//  Created by Zachary Drossman on 9/17/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "Venue.h"
#import "Location.h"

@implementation Venue

- (instancetype)initWithName:(NSString *)name
                     venueId:(NSString *)venueId
                    location:(Location *)location
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


- (instancetype)init
{
    return [self initWithName:@"" venueId:@"" location:[[Location alloc] init]];
}

+ (instancetype)venueWithVenueDictionary:(NSDictionary *)venueDictionary
{
    Location *newLocation = [Location locationWithLocationDictionary:venueDictionary[@"location"]];
    
    Venue *venue = [[Venue alloc] initWithName:venueDictionary[@"name"] venueId:venueDictionary[@"venueId"] location:newLocation];
    
    return venue;
}

+ (NSArray *)venuesWithVenueDictionaries:(NSArray *)venueDictionaries
{
    NSMutableArray *venues = [[NSMutableArray alloc] init];
    for (NSDictionary *venueDictionary in venueDictionaries)
    {
        Venue *newVenue = [Venue venueWithVenueDictionary:venueDictionary];
        
        [venues addObject:newVenue];
    }
    
    return venues;
}
@end
