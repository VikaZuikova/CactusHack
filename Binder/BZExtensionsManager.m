//
//  BZExtensionsManager.m
//  ScrollViewTask
//
//  Created by BZ on 2/15/16.
//  Copyright © 2016 BZ. All rights reserved.
//

#import "BZExtensionsManager.h"

static NSDate *theLastLogDate;

NSString * _Nullable getLogFileContent()
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"Acid.txt"];
    
    //read the whole file as a single string
    NSString *content = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    return content;
}

void removeLogs()
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"Acid.txt"];
    
    //create file if it doesn't exist
    if([[NSFileManager defaultManager] fileExistsAtPath:fileName])
    {
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    }
}

BOOL isEqual(id _Nullable theObject1, id _Nullable theObject2)
{
    if (!theObject1 && !theObject2)
    {
        return YES;
    }
    return [theObject1 isEqual:theObject2];
}

NSString * _Nullable  sfs(SEL _Nonnull theSelector)
{
    if (!theSelector)
    {
        abort();
    }
    return NSStringFromSelector(theSelector);
}

NSString * _Nullable sfc(Class _Nonnull theClass)
{
    if (!theClass)
    {
        BZAssert(nil);
    }
    return NSStringFromClass(theClass);
}

@implementation BZExtensionsManager

#pragma mark - Class Methods (Public)

+ (NSString *)methodValidateIpAddress:(NSString * _Nullable)theIPAddress
{
    NSArray *theAddressesArray = [theIPAddress componentsSeparatedByString:@"."];
    if (!theAddressesArray || theAddressesArray.count != 4)
    {
        return nil;
    }
    NSMutableString *theResultString = [NSMutableString new];
    int theCounter = 0;
    for (NSString *theAddressString in theAddressesArray)
    {
        if (theAddressString.length < 1 || theAddressString.length > 3)
        {
            return nil;
        }
        BOOL isFirstZero = YES;
        if (!isEqual([theAddressString substringWithRange:NSMakeRange(0, 1)], @"0"))
        {
            [theResultString appendString:[theAddressString substringWithRange:NSMakeRange(0, 1)]];
            isFirstZero = NO;
        }
        if (theAddressString.length > 1 && (!isFirstZero || !isEqual([theAddressString substringWithRange:NSMakeRange(1, 1)], @"0")))
        {
            [theResultString appendString:[theAddressString substringWithRange:NSMakeRange(1, 1)]];
        }
        if (theAddressString.length > 2)
        {
            [theResultString appendString:[theAddressString substringWithRange:NSMakeRange(2, 1)]];
        }
        if (theCounter != 3)
        {
            [theResultString appendString:@"."];
        }
        theCounter++;
    }
    return theResultString;
}

+ (BOOL)methodIsIPAddressCorrect:(NSString * _Nullable)theIPAddress
{
    if (!theIPAddress)
    {
        return NO;
    }
    theIPAddress = [theIPAddress stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    theIPAddress = [theIPAddress stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    NSArray *components = [theIPAddress componentsSeparatedByString:@"."];
    if (components.count != 4)
    {
        return NO;
    }
    NSCharacterSet *unwantedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if ([theIPAddress rangeOfCharacterFromSet:unwantedCharacters].location != NSNotFound)
    {
        return NO;
    }
    for (NSString *string in components)
    {
        if ((string.length < 1) || (string.length > 3 ))
        {
            return NO;
        }
        if (string.intValue > 255)
        {
            return NO;
        }
    }
    if  ([[components objectAtIndex:0] intValue] == 0)
    {
        return NO;
    }
    return YES;
}

+ (NSString *)splashImageNameForOrientation:(UIInterfaceOrientation)orientation {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString* viewOrientation = @"Portrait";
    if (orientation == UIInterfaceOrientationPortrait) {
        viewSize = CGSizeMake(viewSize.height, viewSize.width);
        viewOrientation = @"Landscape";
    }
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            return dict[@"UILaunchImageName"];
    }
    return nil;
}

+ (void)methodDispatchAfterSeconds:(double)theSeconds
                         withBlock:(void (^ _Nonnull)())theBlock
{
    NSDate *theStartDate = [NSDate new];
    BZAssert(theBlock && theSeconds >= 0);
    BOOL isMainThread = [[NSThread currentThread] isMainThread];
    [BZExtensionsManager methodAsyncBackgroundWithBlock:^
     {
         NSDate *theCurrentDate = [NSDate new];
         [NSThread sleepForTimeInterval:theSeconds - [theCurrentDate timeIntervalSinceDate:theStartDate]];
         if (isMainThread)
         {
             [BZExtensionsManager methodAsyncMainWithBlock:^
              {
                  theBlock();
              }];
         }
         else
         {
             theBlock();
         }
     }];
}

+ (void)methodAsyncMainWithBlock:(void (^ _Nonnull)())theBlock
{
    if (!theBlock)
    {
        BZAssert(nil);
    }
    dispatch_async(dispatch_get_main_queue(), theBlock);
}

+ (void)methodAsyncBackgroundWithBlock:(void (^ _Nonnull)())theBlock
{
    if (!theBlock)
    {
        BZAssert(nil);
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), theBlock);
    //    BZSyncBackground *theBZSyncBackground = [BZSyncBackground new];
    //    [theBZSyncBackground methodSyncBackgroundWithBlock:theBlock];
}

+ (void)methodSyncMainWithBlock:(void (^ _Nonnull)())theBlock
{
    if (!theBlock)
    {
        BZAssert(nil);
    }
    dispatch_sync(dispatch_get_main_queue(), theBlock);
}

+ (BZDevice)getDevice
{
    UIInterfaceOrientation theDeviceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CGSize theSize = [UIScreen mainScreen].bounds.size;
        double theSpecialMetric;
        if (theDeviceOrientation == UIInterfaceOrientationPortrait || theDeviceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            theSpecialMetric = theSize.height;
        }
        else
        {
            theSpecialMetric = theSize.width;
        }
        if (theSpecialMetric == 1024)
        {
            return BZDeviceIpad;
        }
        if (theSpecialMetric == 1366)
        {
            return BZDeviceIpadPro;
        }
        return BZDeviceIpad;
    }
    else
    {
        CGSize theSize = [UIScreen mainScreen].bounds.size;
        double theSpecialMetric;
        if (theDeviceOrientation == UIInterfaceOrientationPortrait || theDeviceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            theSpecialMetric = theSize.height;
        }
        else
        {
            theSpecialMetric = theSize.width;
        }
        if (theSpecialMetric == 480)
        {
            return BZDeviceIphone4;
        }
        if (theSpecialMetric == 568)
        {
            return BZDeviceIphone5;
        }
        if (theSpecialMetric == 667)
        {
            return BZDeviceIphone6;
        }
        if (theSpecialMetric == 736)
        {
            return BZDeviceIphone6Plus;
        }
    }
    return BZDeviceUndefined;
}

+ (BZDevice)getClothestDevice
{
    UIInterfaceOrientation theDeviceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    CGSize theSize = [UIScreen mainScreen].bounds.size;
    double theSpecialMetric;
    if (theDeviceOrientation == UIInterfaceOrientationPortrait || theDeviceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        theSpecialMetric = theSize.height;
    }
    else
    {
        theSpecialMetric = theSize.width;
    }
    NSMutableArray<NSNumber *> *theValuesArray = [NSMutableArray arrayWithObjects:@(480), @(568), @(667), @(736), @(1024), @(1366), nil];
    NSMutableArray<NSNumber *> *theFloorsArray = [NSMutableArray new];
    for (int i = 0; i < theValuesArray.count; i++)
    {
        double theValue = theValuesArray[i].doubleValue;
        theValue = fabs(theValue - theSpecialMetric);
        [theFloorsArray addObject:@(theValue)];
    }
    for (int i = 0; i < theFloorsArray.count; i++)
    {
        for (int j = 0; j < theFloorsArray.count - 1; j++)
        {
            if (theFloorsArray[j + 1].doubleValue < theFloorsArray[j].doubleValue)
            {
                NSNumber *theTemp = theFloorsArray[j+1];
                theFloorsArray[j+1] = theFloorsArray[j];
                theFloorsArray[j] = theTemp;
                NSNumber *theTemp2 = theValuesArray[j+1];
                theValuesArray[j+1] = theValuesArray[j];
                theValuesArray[j] = theTemp2;
            }
        }
    }
    theSpecialMetric = theValuesArray[0].doubleValue;
    if (theSpecialMetric == 480)
    {
        return BZDeviceIphone4;
    }
    if (theSpecialMetric == 568)
    {
        return BZDeviceIphone5;
    }
    if (theSpecialMetric == 667)
    {
        return BZDeviceIphone6;
    }
    if (theSpecialMetric == 736)
    {
        return BZDeviceIphone6Plus;
    }
    if (theSpecialMetric == 1024)
    {
        return BZDeviceIpad;
    }
    if (theSpecialMetric == 1366)
    {
        return BZDeviceIpadPro;
    }
    return BZDeviceIphone4;
    BZAssert(nil);
}

+ (void)methodPrintAllFonts
{
    for (NSString *theFamily in [UIFont familyNames])
    {
        NSLog(@"%@", theFamily);
        for (NSString *theName in [UIFont fontNamesForFamilyName:theFamily])
        {
            NSLog(@" %@", theName);
        }
    }
}

+ (double)methodGetStatusBarHeight
{
//    return [UIApplication sharedApplication].statusBarFrame.size.height;
    return 20;
}

+ (BOOL)methodIsIOS8
{
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0)
    {
        return YES;
    }
    return NO;
}

+ (NSString * _Nonnull)methodGetHexFromDecimal:(NSInteger)theDecimal withFormatCount:(NSUInteger)theFormatCount withPrefix:(BOOL)isPrefix
{
    if (theFormatCount < 1)
    {
        return @"";
    }
    NSString *theResult = nil;
    if (theFormatCount == 1)
    {
        theResult = [NSString stringWithFormat:@"%01x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 2)
    {
        theResult = [NSString stringWithFormat:@"%02x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 3)
    {
        theResult = [NSString stringWithFormat:@"%03x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 4)
    {
        theResult = [NSString stringWithFormat:@"%04x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 5)
    {
        theResult = [NSString stringWithFormat:@"%05x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 6)
    {
        theResult = [NSString stringWithFormat:@"%06x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 7)
    {
        theResult = [NSString stringWithFormat:@"%07x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 8)
    {
        theResult = [NSString stringWithFormat:@"%08x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 9)
    {
        return [NSString stringWithFormat:@"%09x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 10)
    {
        theResult = [NSString stringWithFormat:@"%010x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 11)
    {
        theResult = [NSString stringWithFormat:@"%011x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 12)
    {
        theResult = [NSString stringWithFormat:@"%012x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 13)
    {
        theResult = [NSString stringWithFormat:@"0x%013x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 14)
    {
        theResult = [NSString stringWithFormat:@"%014x", (unsigned int)theDecimal];
    }
    else if (theFormatCount == 15)
    {
        theResult = [NSString stringWithFormat:@"%015x", (unsigned int)theDecimal];
    }
    else
    {
        return @"";
    }
    if (isPrefix)
    {
        return [NSString stringWithFormat:@"0x%@", theResult];
    }
    else
    {
        return theResult;
    }
}

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

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

+ (void)selectorWithBlock:(void (^ _Nonnull)())theBlock
{
    theBlock();
}

#pragma mark - Standard Methods

@end






























