//
//  GetProfileTask.h
//  Binder
//
//  Created by User on 13.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetworkTask.h"

@interface GetProfileTask : NSObject <NetworkTask>

- (void)methodStartWithAccessToken:(NSString * _Nonnull)theAccessToken
                        completion:(void (^_Nonnull)(NSDictionary * _Nullable theDictionary, NSError * _Nullable theError))theCompletion;

@end






























