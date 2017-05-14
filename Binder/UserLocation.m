//
//  UserLocation.m
//  Binder
//
//  Created by User on 13.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "UserLocation.h"

#import <CoreLocation/CoreLocation.h>

@implementation UserLocation

- (BOOL)methodIsFresh
{
    if (!self.theLastUpdateDate)
    {
        return NO;
    }
    NSDate *theCurrentDate = [NSDate new];
    if ([theCurrentDate timeIntervalSinceDate:self.theLastUpdateDate] < 1800)
    {
        return YES;
    }
    return NO;
}

- (double)methodCountDistanceTo:(UserLocation * _Nonnull)theLocation
{
    CLLocation *theStartLocation = [[CLLocation alloc] initWithLatitude:self.theLatitude  longitude:self.theLongitude];
    CLLocation *theEndLocation = [[CLLocation alloc] initWithLatitude:theLocation.theLatitude longitude:theLocation.theLongitude];
    CLLocationDistance theDistance = [theStartLocation distanceFromLocation:theEndLocation];
    return theDistance;
}

@end






























