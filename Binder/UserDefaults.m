//
//  UserDefaults.m
//  Int20H
//
//  Created by User on 04.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "UserDefaults.h"

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

- (void)setTheAccessToken:(NSString * _Nullable)theAccessToken
{
    [self.theNSUserDefaults setObject:theAccessToken forKey:sfs(@selector(theAccessToken))];
    [self.theNSUserDefaults synchronize];
}

#pragma mark - Getters (Public)

- (NSString *)theAccessToken
{
    return [self.theNSUserDefaults objectForKey:sfs(@selector(theAccessToken))];
}

#pragma mark - Setters (Private)

#pragma mark - Getters (Private)

#pragma mark - Lifecycle

#pragma mark - Create Views & Variables

#pragma mark - Actions

#pragma mark - Gestures

#pragma mark - Delegates ()

#pragma mark - Methods (Public)

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

@end






























