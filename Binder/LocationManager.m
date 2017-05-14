//
//  LocationManager.m
//  Binder
//
//  Created by User on 14.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "LocationManager.h"

#import "User.h"
#import "UserLocation.h"
#import "AddFireTask.h"

#import "BZExtensionsManager.h"

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *theManager;
@property (nonatomic, strong) User *theUser;
@property (nonatomic, strong) NSTimer *theFireTimer;
@property (nonatomic, strong) AddFireTask *theTask;

@end

@implementation LocationManager

- (instancetype _Nonnull)initWithUser:(User * _Nonnull)theUser
{
    self = [super init];
    if (self)
    {
        _theManager = [CLLocationManager new];
        _theManager.delegate = self;
        _theUser = theUser;
        [_theManager startUpdatingLocation];
        [_theManager requestAlwaysAuthorization];
        _theManager.allowsBackgroundLocationUpdates = YES;
        _theManager.pausesLocationUpdatesAutomatically = NO;
        _theManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_theManager startMonitoringSignificantLocationChanges];
    }
    return self;
}

- (void)setIsActiveMode:(BOOL)isActiveMode
{
    if (_isActiveMode == isActiveMode)
    {
        return;
    }
    _isActiveMode = isActiveMode;
    if (isActiveMode)
    {
        [self.theManager disallowDeferredLocationUpdates];
    }
    else
    {
        [self.theManager allowDeferredLocationUpdatesUntilTraveled:1 timeout:60];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"%f %f", locations[0].coordinate.latitude, locations[0].coordinate.longitude);
    UserLocation *theLocation;
    if (self.theUser.theUserLocation)
    {
        theLocation = self.theUser.theUserLocation;
    }
    else
    {
        theLocation = [UserLocation new];
        [self.theUser methodBindLocation:theLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"keyAddedNew" object:nil];
    }
    theLocation.theLatitude = locations[0].coordinate.latitude;
    theLocation.theLongitude = locations[0].coordinate.longitude;
    if (!_theTask)
    {
        _theTask = [AddFireTask new];
        [_theTask methodAddUser:self.theUser];
    }
}

- (void)methodStartUpdateMonitor
{
    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:300
                                                         target:self  selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
    self.theFireTimer = theTimer;
    [[NSRunLoop currentRunLoop] addTimer:theTimer forMode:NSRunLoopCommonModes];
}

- (void)timerDidFire:(NSTimer *)theTimer
{
    [self.theManager requestLocation];
}

@end






























