//
//  UserLocation.h
//  Binder
//
//  Created by User on 13.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLocation : NSObject

@property (nonatomic, assign) double theLongitude;
@property (nonatomic, assign) double theLatitude;
@property (nonatomic, strong, nonnull) NSDate *theLastUpdateDate;

- (BOOL)methodIsFresh;
- (double)methodCountDistanceTo:(UserLocation * _Nonnull)theLocation;

@end






























