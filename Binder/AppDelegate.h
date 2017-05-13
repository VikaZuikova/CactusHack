//
//  AppDelegate.h
//  Int20H
//
//  Created by User on 04.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class AppConfig;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong, nonnull) UIWindow *window;
@property (strong, nonnull, readonly) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) AppConfig *theConfig;

- (void)saveContext;

+ (AppDelegate * _Nonnull)sharedInstance;

@end






























