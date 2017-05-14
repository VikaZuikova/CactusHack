//
//  AppConfig.h
//  Binder
//
//  Created by User on 13.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class LocationManager;
@protocol AppConfigDelegate;

@interface AppConfig : NSObject

@property (nonatomic, strong, nullable) User *theUser;

@property (nonatomic, strong, nonnull) LocationManager *theLocationManager;

- (void)methodSubscribe:(id<AppConfigDelegate> _Nonnull)theSubscriber;
- (void)methodUnsubscribe:(id<AppConfigDelegate> _Nonnull)theSubscriber;

@end

@protocol AppConfigDelegate <NSObject>

- (void)userDidAuthorized:(User * _Nonnull)theUser;
- (void)userUpdateProfile:(User * _Nonnull)theUser;

@end




























