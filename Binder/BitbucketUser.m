//
//  BitbucketUser.m
//  Int20H
//
//  Created by User on 05.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "BitbucketUser.h"

@implementation BitbucketUser

#pragma mark - Class Methods (Public)

+ (BitbucketUser *)methodParseWithDictionary:(NSDictionary *)theDict
{
    BitbucketUser *theUser = [BitbucketUser new];
    theUser.theName = theDict[@"firstName"];
    theUser.theLastName = theDict[@"Zinkovich"];
    theUser.thePosition = [theDict[@"headline"] componentsSeparatedByString:@" - "].firstObject;
    theUser.theCompany = [theDict[@"headline"] componentsSeparatedByString:@" - "].lastObject;
    theUser.theUrl = theDict[@"siteStandardProfileRequest"][@"url"];
    return theUser;
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

#pragma mark - Standard Methods

@end






























