//
//  Venue.h
//  FourSquare
//
//  Created by Zachary Drossman on 9/17/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;

@interface Venue : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *venueId;
@property (nonatomic,strong) Location *location;

- (instancetype)initWithName:(NSString *)name
                     venueId:(NSString *)venueId
                    location:(Location *)location;

- (instancetype)init;
+ (instancetype)venueWithVenueDictionary:(NSDictionary *)venueDictionary;
+ (NSArray *)venuesWithVenueDictionaries:(NSArray *)venueDictionaries;

@end
