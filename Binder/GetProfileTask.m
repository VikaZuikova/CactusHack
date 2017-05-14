//
//  GetProfileTask.m
//  Binder
//
//  Created by User on 13.05.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "GetProfileTask.h"

#import "BZURLSession.h"

@interface GetProfileTask ()

@property (nonatomic, strong) BZURLSession *theSession;

@end

@implementation GetProfileTask

- (void)methodStartWithAccessToken:(NSString * _Nonnull)theAccessToken
                        completion:(void (^_Nonnull)(NSDictionary * _Nullable theDictionary, NSError * _Nullable theError))theCompletion
{
    NSString *url= [NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(id,picture-url,first-name,last-name,headline,site-standard-profile-request)?oauth2_access_token=%@&format=json", theAccessToken];
    NSURL *theUrl = [NSURL URLWithString:url];
    NSLog(@"%@", theUrl);
    BZURLSession *theSession = [BZURLSession new];
    self.theSession = theSession;
    [theSession methodStartDownloadTaskWithURL:theUrl
                                 progressBlock:nil completionBlockWithData:^(NSData * _Nullable data, NSError * _Nullable theError)
    {
        if (theError)
        {
            theCompletion(nil, theError);
            return;
        }
        NSDictionary *theResultDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:kNilOptions
                                                                              error:&theError];
        theCompletion(theResultDictionary, theError);
    }];
}

- (void)methodCancel
{
    [self.theSession methodStop];
}

@end






























