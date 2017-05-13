//
//  BitbucketUser.m
//  Int20H
//
//  Created by User on 05.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "User.h"

#import "UserLocation.h"
#import "UserDefaults.h"

@interface User ()

@property (nonatomic, strong, nonnull) NSString *theName;
@property (nonatomic, strong, nonnull) NSString *theLastName;
@property (nonatomic, strong, nonnull) NSString *thePosition;
@property (nonatomic, strong, nonnull) NSString *theCompany;
@property (nonatomic, strong, nonnull) NSString *theBitbucketUrl;
@property (nonatomic, strong, nullable) UserLocation *theUserLocation;

@end

@implementation User

#pragma mark - Class Methods (Public)

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

- (instancetype _Nonnull)initWithDictionary:(NSDictionary *)theDict
{
    self = [super init];
    if (self)
    {
        _theName = theDict[@"firstName"];
        _theLastName = theDict[@"Zinkovich"];
        _thePosition = [theDict[@"headline"] componentsSeparatedByString:@" - "].firstObject;
        _theCompany = [theDict[@"headline"] componentsSeparatedByString:@" - "].lastObject;
        _theBitbucketUrl = theDict[@"siteStandardProfileRequest"][@"url"];
    }
    return self;
}

- (instancetype _Nullable)initWithUserDefaults:(UserDefaults * _Nonnull)theDefaults
{
    self = [super init];
    if (self)
    {
        if (![UserDefaults sharedInstance].theAccessToken)
        {
            return nil;
        }
        _theName = theDefaults.theName;
        _theLastName = theDefaults.theLastName;
        _thePosition = theDefaults.theWorkPosition;
        _theCompany = theDefaults.theWorkPlace;
        _theBitbucketUrl = theDefaults.theUserBitbucketUrl;
    }
    return self;
}

#pragma mark - Setters (Public)

#pragma mark - Getters (Public)

#pragma mark - Setters (Private)

#pragma mark - Getters (Private)

#pragma mark - Lifecycle

#pragma mark - Create Views & Variables

#pragma mark - Actions

#pragma mark - Gestures

#pragma mark - Delegates ()

#pragma mark - Methods (Public)

- (void)methodBindLocation:(UserLocation * _Nonnull)theLocation
{
    _theUserLocation = theLocation;
}

- (void)methodUpdateProfile
{
    
}

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

@end






























