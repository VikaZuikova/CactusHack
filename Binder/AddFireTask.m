//
//  AddFireTask.m
//  Binder
//
//  Created by User on 14.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "AddFireTask.h"

#import "User.h"
#import "UserLocation.h"

#import <FirebaseDatabase/FirebaseDatabase.h>
#import <Firebase/Firebase.h>

@implementation AddFireTask

- (void)methodAddUser:(User * _Nonnull)theUser
{
    FIRDatabaseReference *reference = [[FIRDatabase database] reference];
//    [[[_ref child:@"users"] child:user.uid]
//     setValue:@{@"username": username}];
    NSDictionary *theInternalDict = [NSDictionary dictionaryWithObjectsAndKeys:theUser.theName, @"first_name", theUser.theLastName, @"last_name", theUser.theUserPuctureUrl, @"image_url", theUser.theCompany, @"place_of_work", theUser.thePosition, @"speciality", [NSString stringWithFormat:@"%.6f", theUser.theUserLocation.theLongitude], @"longitude", [NSString stringWithFormat:@"%.6f", theUser.theUserLocation.theLatitude], @"latitude", theUser.theLinkedInProfileUrl, @"linkedIn_url", nil];
//    [NSString stringWithFormat:@"user%@", theUser.theUserID];
    reference = [reference child:@"Users"];
    reference = [reference child:[NSString stringWithFormat:@"user%@", theUser.theUserID]];
    [reference setValue:theInternalDict];
}

- (void)methodUpdateUser
{
   ;
}

@end
