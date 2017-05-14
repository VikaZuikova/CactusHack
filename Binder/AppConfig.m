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
#import "LocationManager.h"

#import "BZExtensionsManager.h"

@interface AppConfig ()

@property (nonatomic, strong) NSHashTable<id<AppConfigDelegate>> *theListeners;

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
        [self methodInitAppConfig];
    }
    return self;
}

- (void)methodInitAppConfig
{
    self.theUser = [[User alloc] initWithUserDefaults:[UserDefaults sharedInstance]];
}

#pragma mark - Setters (Public)

- (void)setTheUser:(User *)theUser
{
    if (!theUser)
    {
        return;
    }
    _theUser = theUser;
    _theLocationManager = [[LocationManager alloc] initWithUser:_theUser];
    for (id<AppConfigDelegate> theDelegate in self.theListeners)
    {
        if ([theDelegate respondsToSelector:@selector(userDidAuthorized:)])
        {
            [theDelegate userDidAuthorized:theUser];
        }
    }
}

#pragma mark - Getters (Public)

#pragma mark - Setters (Private)

#pragma mark - Getters (Private)

#pragma mark - Lifecycle

#pragma mark - Create Views & Variables

#pragma mark - Actions

#pragma mark - Gestures

#pragma mark - Delegates ()

#pragma mark - Methods (Public)

- (void)methodSubscribe:(id<AppConfigDelegate> _Nonnull)theListener
{
    if (!theListener)
    {
        return;
    }
    if (!self.theListeners)
    {
        self.theListeners = [NSHashTable weakObjectsHashTable];
    }
    if (![self.theListeners containsObject:theListener])
    {
        [self.theListeners addObject:theListener];
    }
}

- (void)methodUnsubscribe:(id<AppConfigDelegate> _Nonnull)theListener
{
    if (!theListener || !self.theListeners)
    {
        return;
    }
    [self.theListeners removeObject:theListener];
}

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

@end






























