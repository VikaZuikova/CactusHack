//
//  UserDefaults.h
//  Int20H
//
//  Created by User on 04.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

@property (nonatomic, strong, nullable) NSString *theAccessToken;

+ (UserDefaults * _Nonnull)sharedInstance;

@end






























