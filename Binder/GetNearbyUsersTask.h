//
//  GetNearbyUsersTask.h
//  Binder
//
//  Created by User on 14.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface GetNearbyUsersTask : NSObject

- (instancetype _Nonnull)initWithCurrentUser:(User * _Nonnull)theUser;
- (void)methodStartWithUpdatedBlock:(void (^_Nonnull)(NSArray<User *> * _Nonnull theNewList))theBlock
                        withFailure:(void (^_Nonnull)(NSError * _Nonnull theError))theFailure;

@end






























