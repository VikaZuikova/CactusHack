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
@property (nonatomic, strong, nonnull, readonly) NSString *theLinkedInProfileUrl;
@property (nonatomic, strong, nonnull, readonly) NSString *theAccessToken;
@property (nonatomic, strong, nonnull, readonly) NSString *theUserPuctureUrl;
@property (nonatomic, strong, nonnull, readonly) NSString *theUserID;
@property (nonatomic, strong, nullable, readonly) UserLocation *theUserLocation;

- (instancetype _Nonnull)initWithDictionary:(NSDictionary * _Nonnull)theDict withAccessToken:(NSString * _Nonnull)theToken;
- (instancetype _Nonnull)initWithSnapshotDictionary:(NSDictionary * _Nonnull)theDict;
- (instancetype _Nullable)initWithUserDefaults:(UserDefaults * _Nonnull)theDefaults;
- (void)methodBindLocation:(UserLocation * _Nonnull)theLocation;
- (void)methodUpdateProfile;

@end






























