//
//  BZExtensionsManager.h
//  ScrollViewTask
//
//  Created by BZ on 2/15/16.
//  Copyright © 2016 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+BZExtensions.h"
#import "UIView+BZExtensions.h"
#import "UIImage+BZExtensions.h"
#import "NSObject+BZExtensions.h"
#import "BZURLSession.h"
#import "UIColor+BZExtensions.h"

#ifdef DEBUG
#define BZAssert(var) \
if (!(BOOL)var) \
{ \
abort(); \
}
#else
#define BZAssert(var)
#endif

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

BOOL isEqual(id _Nullable theObject1, id _Nullable theObject2);
NSString * _Nullable sfs(SEL _Nonnull theSelector);
NSString * _Nullable sfc(Class _Nonnull theClass);
NSString * _Nullable getLogFileContent();
void removeLogs();

typedef enum : NSUInteger
{
    BZDeviceIphone4 = 1,
    BZDeviceIphone5 = 2,
    BZDeviceIphone6 = 3,
    BZDeviceIphone6Plus = 4,
    BZDeviceIpad = 5,
    BZDeviceIpadPro = 6,
    BZDeviceUndefined = 7,
    BZDevicesCount = BZDeviceUndefined
} BZDevice;

@interface BZExtensionsManager : NSObject

+ (double)methodGetStatusBarHeight;
+ (void)methodAsyncMainWithBlock:(void (^ _Nonnull)())theBlock;
+ (void)methodAsyncBackgroundWithBlock:(void (^ _Nonnull)())theBlock;
+ (void)methodSyncMainWithBlock:(void (^ _Nonnull)())theBlock;
+ (void)methodDispatchAfterSeconds:(double)theSeconds
                         withBlock:(void (^ _Nonnull)())theBlock;

+ (BZDevice)getDevice;
+ (BZDevice)getClothestDevice;
+ (void)methodPrintAllFonts;
+ (BOOL)methodIsIOS8;
+ (NSString * _Nullable)splashImageNameForOrientation:(UIInterfaceOrientation)orientation;
+ (BOOL)methodIsIPAddressCorrect:(NSString * _Nullable)theIPAddress;
+ (NSString * _Nullable)methodValidateIpAddress:(NSString * _Nullable)theIPAddress;
+ (NSString * _Nonnull)methodGetHexFromDecimal:(NSInteger)theDecimal withFormatCount:(NSUInteger)theFormatCount withPrefix:(BOOL)isPrefix;

@end






























