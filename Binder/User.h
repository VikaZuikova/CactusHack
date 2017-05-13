//
//  BitbucketUser.h
//  Int20H
//
//  Created by User on 05.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserLocation;
@class UserDefaults;

@interface User : NSObject

@property (nonatomic, strong, nonnull, readonly) NSString *theName;
@property (nonatomic, strong, nonnull, readonly) NSString *theLastName;
@property (nonatomic, strong, nonnull, readonly) NSString *thePosition;
@property (nonatomic, strong, nonnull, readonly) NSString *theCompany;
@property (nonatomic, strong, nonnull, readonly) NSString *theBitbucketUrl;
@property (nonatomic, strong, nullable, readonly) UserLocation *theUserLocation;

- (instancetype _Nonnull)initWithDictionary:(NSDictionary * _Nonnull)theDict;
- (instancetype _Nullable)initWithUserDefaults:(UserDefaults * _Nonnull)theDefaults;
- (void)methodBindLocation:(UserLocation * _Nonnull)theLocation;
- (void)methodUpdateProfile;

@end






























