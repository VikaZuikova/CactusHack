//
//  GetNearbyUsersTask.m
//  Binder
//
//  Created by User on 14.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "GetNearbyUsersTask.h"

#import "User.h"
#import "UserLocation.h"
#import "BZExtensionsManager.h"

#import <FirebaseDatabase/FirebaseDatabase.h>
#import <Firebase/Firebase.h>

@interface GetNearbyUsersTask ()

@property (nonatomic, strong) NSMutableArray<User *> *theUserList;
@property (nonatomic, strong) User *theCurrentUser;
@property (nonatomic, strong) NSTimer *theFireTimer;
@property (nonatomic, strong) NSMutableArray<User *> *theCachedArray;
@property (nonatomic, copy, nullable) void (^blockName)(NSArray<User *> * _Nonnull theNewList);

@end

@implementation GetNearbyUsersTask

- (instancetype _Nonnull)initWithCurrentUser:(User * _Nonnull)theUser
{
    self = [super init];
    if (self)
    {
        _theCurrentUser = theUser;
        _theUserList = [NSMutableArray new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAppearedLocation:) name:@"keyAddedNew" object:nil];
    }
    return self;
}

- (void)methodStartWithUpdatedBlock:(void (^_Nonnull)(NSArray<User *> * _Nonnull theNewList))theBlock
                        withFailure:(void (^_Nonnull)(NSError * _Nonnull theError))theFailure
{
    self.blockName = theBlock;
    FIRDatabaseReference *reference = [[FIRDatabase database] reference];
    [reference observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
     {
         NSLog(@"%@", snapshot.value);
         [BZExtensionsManager methodAsyncBackgroundWithBlock:^
         {
             BOOL hasNewUser = NO;
             if (!_theCurrentUser.theUserLocation)
             {
                 self.theCachedArray = [self methodProcessResponse:snapshot.value];
                 return;
             }
             NSArray *theUsersList =  [self methodFilterUsersWithCurrentLocation:_theCurrentUser.theUserLocation withUsers:[self methodProcessResponse:snapshot.value]] ;
             if (self.theUserList.count)
             {
                 NSMutableArray *theNewUsersList = [self methodFilterUsersWithCurrentLocation:_theCurrentUser.theUserLocation withUsers:self.theUserList];
                 if (theNewUsersList.count != self.theUserList.count)
                 {
                     hasNewUser = YES;
                     self.theUserList = theNewUsersList;
                 }
             }
             if (theUsersList.count || hasNewUser)
             {
                 [self.theUserList addObjectsFromArray:theUsersList];
                 theBlock(self.theUserList);
             }
         }];
     }];
}

- (NSMutableArray<User *> * _Nullable)methodProcessResponse:(NSDictionary * _Nonnull)theResponse
{
    if (!theResponse)
    {
        return nil;
    }
    NSLog(@"%@", theResponse);
    NSMutableArray<User *> *theUsersArray = [NSMutableArray new];
    for (NSString *theKey in theResponse.allKeys)
    {
        NSDictionary * theDict = theResponse[theKey];
        if (![theDict isKindOfClass:[NSDictionary class]])
        {
            return theUsersArray;
        }
        User *theCurrentUser = [[User alloc] initWithSnapshotDictionary:theDict];
        if ([[theKey substringFromIndex:4] isEqualToString:self.theCurrentUser.theUserID])
        {
            continue;
        }
        UserLocation *theLocation = [UserLocation new];
        theLocation.theLastUpdateDate = [NSDate new];
        theLocation.theLatitude = [[NSString stringWithFormat:@"%@", theDict[@"latitude"]] doubleValue];
        theLocation.theLongitude =  [[NSString stringWithFormat:@"%@", theDict[@"longitude"]] doubleValue];
        [theCurrentUser methodBindLocation:theLocation];

        [theUsersArray addObject:theCurrentUser];
    }
    return theUsersArray;
}

- (NSMutableArray<User *> * _Nonnull)methodFilterUsersWithCurrentLocation:(UserLocation * _Nonnull)theLocation
                                                         withUsers:(NSArray<User *> * _Nonnull)theUsers
{
    NSMutableArray *theNewArray = [NSMutableArray new];
    if (!theLocation)
    {
        return theNewArray;
    }
    for (User * theUser in theUsers)
    {
        if (!theUser.theUserLocation || ![theUser.theUserLocation methodIsFresh])
        {
            continue;
        }
        if ([theLocation methodCountDistanceTo:theUser.theUserLocation] < 400)
        {
            [theNewArray addObject:theUser];
            continue;
        }
    }
    return theNewArray;
}

- (void)methodStartDeleteOldTimeout
{
    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:300
                                                         target:self  selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
    self.theFireTimer = theTimer;
    [[NSRunLoop currentRunLoop] addTimer:theTimer forMode:NSRunLoopCommonModes];
}

- (void)timerDidFire:(NSTimer *)theTimer
{
#warning need realize
}

- (void)receiveAppearedLocation:(NSNotification *)theNotif
{
    BOOL hasNewUser = NO;
    NSArray *theUsersList =  [self methodFilterUsersWithCurrentLocation:_theCurrentUser.theUserLocation withUsers:self.theCachedArray] ;
    if (self.theUserList.count)
    {
        NSMutableArray *theNewUsersList = [self methodFilterUsersWithCurrentLocation:_theCurrentUser.theUserLocation withUsers:self.theUserList];
        if (theNewUsersList.count != self.theUserList.count)
        {
            hasNewUser = YES;
            self.theUserList = theNewUsersList;
        }
    }
    if (theUsersList.count || hasNewUser)
    {
        [self.theUserList addObjectsFromArray:theUsersList];
        self.blockName(self.theUserList);
    }

}

@end






























