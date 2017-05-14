//
//  UserDefaults.m
//  Int20H
//
//  Created by User on 04.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "UserDefaults.h"

#import "User.h"

#import "BZExtensionsManager.h"

@interface UserDefaults ()

@property (nonatomic, strong, nullable) NSUserDefaults *theNSUserDefaults;

@end

@implementation UserDefaults

#pragma mark - Class Methods (Public)

+ (UserDefaults * _Nonnull)sharedInstance
{
    static UserDefaults *theUserDefaults;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      theUserDefaults = [[UserDefaults alloc] initSharedInstance];
                  });
    return theUserDefaults;
}

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

- (instancetype)initSharedInstance
{
    self = [super init];
    if (self)
    {
        [self methodInitUserDefaults];
    }
    return self;
}

- (void)methodInitUserDefaults
{
    self.theNSUserDefaults =[NSUserDefaults standardUserDefaults];
}

#pragma mark - Setters (Public)

- (void)setTheWorkPosition:(NSString *)theWorkPosition
{
    [self.theNSUserDefaults setObject:theWorkPosition forKey:sfs(@selector(theWorkPosition))];
    [self.theNSUserDefaults synchronize];
}

- (void)setTheWorkPlace:(NSString *)theWorkPlace
{
    [self.theNSUserDefaults setObject:theWorkPlace forKey:sfs(@selector(theWorkPlace))];
    [self.theNSUserDefaults synchronize];
}

- (void)setTheName:(NSString *)theName
{
    [self.theNSUserDefaults setObject:theName forKey:sfs(@selector(theName))];
    [self.theNSUserDefaults synchronize];
}

- (void)setTheLastName:(NSString *)theLastName
{
    [self.theNSUserDefaults setObject:theLastName forKey:sfs(@selector(theLastName))];
    [self.theNSUserDefaults synchronize];
}

- (void)setTheUserId:(NSString *)theUserId
{
    [self.theNSUserDefaults setObject:theUserId forKey:sfs(@selector(theUserId))];
    [self.theNSUserDefaults synchronize];
}

- (void)setTheUserBitbucketUrl:(NSString *)theUserBitbucketUrl
{
    [self.theNSUserDefaults setObject:theUserBitbucketUrl forKey:sfs(@selector(theUserBitbucketUrl))];
    [self.theNSUserDefaults synchronize];
}

- (void)setTheAccessToken:(NSString * _Nullable)theAccessToken
{
    [self.theNSUserDefaults setObject:theAccessToken forKey:sfs(@selector(theAccessToken))];
    [self.theNSUserDefaults synchronize];
}

- (void)setTheUserPictureUrl:(NSString *)theUserPictureUrl
{
    [self.theNSUserDefaults setObject:theUserPictureUrl forKey:sfs(@selector(theUserPictureUrl))];
    [self.theNSUserDefaults synchronize];
}

#pragma mark - Getters (Public)

- (NSString *)theWorkPlace
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theWorkPlace))];
}

- (NSString *)theWorkPosition
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theWorkPosition))];
}

- (NSString *)theAccessToken
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theAccessToken))];
}

- (NSString *)theLastName
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theLastName))];
}

- (NSString *)theUserId
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theUserId))];
}

- (NSString *)theName
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theName))];
}

- (NSString *)theUserPictureUrl
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theUserPictureUrl))];
}

- (NSString *)theUserBitbucketUrl
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theUserBitbucketUrl))];
}

#pragma mark - Setters (Private)

#pragma mark - Getters (Private)

#pragma mark - Lifecycle

#pragma mark - Create Views & Variables

#pragma mark - Actions

#pragma mark - Gestures

#pragma mark - Delegates ()

#pragma mark - Methods (Public)

- (void)methodSaveUser:(User * _Nonnull)theUser
{
    self.theAccessToken = theUser.theAccessToken;
    self.theLastName = theUser.theLastName;
    self.theName = theUser.theName;
    self.theWorkPlace = theUser.theCompany;
    self.theUserBitbucketUrl = theUser.theLinkedInProfileUrl;
    self.theUserPictureUrl = theUser.theUserPuctureUrl;
    self.theWorkPosition = theUser.thePosition;
    self.theUserId = theUser.theUserID;
}

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

@end






























