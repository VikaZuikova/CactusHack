//
//  LocationManager.h
//  Binder
//
//  Created by User on 14.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@class User;

@interface LocationManager : NSObject

@property (nonatomic, assign) BOOL isActiveMode;

- (instancetype _Nonnull)initWithUser:(User * _Nonnull)theUser;

@end






























