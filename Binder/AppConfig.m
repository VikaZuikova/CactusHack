//
//  AppConfig.m
//  Binder
//
//  Created by User on 13.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "AppConfig.h"

#import "User.h"
#import "UserDefaults.h"

#import "BZExtensionsManager.h"

@interface AppConfig ()

@property (nonatomic, strong, nullable) User *theUser;

@end

@implementation AppConfig

#pragma mark - Class Methods (Public)

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

- (instancetype _Nonnull)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)methodInitAppConfig
{
    _theUser = [[User alloc] initWithUserDefaults:[UserDefaults sharedInstance]];
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

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

@end






























