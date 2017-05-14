//
//  UserDefaults.h
//  Int20H
//
//  Created by User on 04.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface UserDefaults : NSObject

@property (nonatomic, strong, nullable) NSString *theAccessToken;
@property (nonatomic, strong, nullable) NSString *theName;
@property (nonatomic, strong, nullable) NSString *theUserPictureUrl;
@property (nonatomic, strong, nullable) NSString *theLastName;
@property (nonatomic, strong, nullable) NSString *theUserId;
@property (nonatomic, strong, nullable) NSString *theUserBitbucketUrl;
@property (nonatomic, strong, nullable) NSString *theWorkPosition;
@property (nonatomic, strong, nullable) NSString *theWorkPlace;

+ (UserDefaults * _Nonnull)sharedInstance;

- (void)methodSaveUser:(User * _Nonnull)theUser;

@end






























