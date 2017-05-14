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
@property (nonatomic, strong, nonnull) NSString *theLinkedInProfileUrl;
@property (nonatomic, strong, nonnull) NSString *theAccessToken;
@property (nonatomic, strong, nonnull) NSString *theUserPuctureUrl;
@property (nonatomic, strong, nonnull) NSString *theUserID;
@property (nonatomic, strong, nullable) UserLocation *theUserLocation;

@end

@implementation User

#pragma mark - Class Methods (Public)

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

- (instancetype _Nonnull)initWithSnapshotDictionary:(NSDictionary * _Nonnull)theDict
{
    self = [super init];
    if (self)
    {
        NSLog(@"%@", theDict);
        if (!theDict || ![theDict isKindOfClass:[NSDictionary class]] )
        {
            return self;
        }
        _theName = theDict[@"first_name"];
        _theLastName = theDict[@"last_name"];
        _theUserPuctureUrl = theDict[@"image_url"];
        _thePosition = theDict[@"speciality"];
        _theCompany = theDict[@"place_of_work"];
        _theLinkedInProfileUrl = theDict[@"siteStandardProfileRequest"][@"url"];
        UserLocation *theUserLocation = [UserLocation new];
        theUserLocation.theLatitude = [[NSString stringWithFormat:@"%@", theDict[@"latitude"]] doubleValue];
        theUserLocation.theLatitude = [[NSString stringWithFormat:@"%@", theDict[@"latitude"]] doubleValue];
        theUserLocation.theLastUpdateDate = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@", theDict[@"last_update_date"]] doubleValue]];
    }
    return self;
}

- (instancetype _Nonnull)initWithDictionary:(NSDictionary * _Nonnull)theDict withAccessToken:(NSString * _Nonnull)theToken
{
    self = [super init];
    if (self)
    {
        NSLog(@"%@", theDict);
        _theUserID = theDict[@"id"];
        _theName = theDict[@"firstName"];
        _theLastName = theDict[@"lastName"];
        _theUserPuctureUrl = theDict[@"pictureUrl"];
        NSString *theHeadline = theDict[@"headline"];
        _thePosition = [theHeadline componentsSeparatedByString:@"-"].firstObject;
        _theCompany = [theHeadline componentsSeparatedByString:@"-"].lastObject;
        _theLinkedInProfileUrl = theDict[@"siteStandardProfileRequest"][@"url"];
        _theAccessToken = theToken;
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
        _theLinkedInProfileUrl = theDefaults.theUserBitbucketUrl;
        _theAccessToken = theDefaults.theAccessToken;
        _theUserPuctureUrl = theDefaults.theUserPictureUrl;
        _theUserID = theDefaults.theUserId;
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






























