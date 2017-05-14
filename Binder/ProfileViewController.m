//
//  ProfileViewController.m
//  Int20H
//
//  Created by User on 05.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "ProfileViewController.h"

#import "AppConfig.h"
#import "User.h"
#import "AppDelegate.h"

#import "UserDefaults.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:webview];
//    NSString *url=[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~?oauth2_access_token=%@&format=json", [[UserDefaults sharedInstance] theAccessToken]];
//    NSLog(@"%@", url);
//    NSURL *nsurl=[NSURL URLWithString:url];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData *data = [NSData dataWithContentsOfURL:nsurl];
//        NSError *err;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
//        NSLog(@"%@", dict);
//        dispatch_async(dispatch_get_main_queue(), ^ {
//            NSString *webViewURLString = [NSString stringWithFormat:@"%@", [[dict objectForKey:@"siteStandardProfileRequest"] objectForKey:@"url"]];
//            NSURL *webViewURL = [NSURL URLWithString:webViewURLString];
            NSURL *webViewURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[AppDelegate sharedInstance].theConfig.theUser.theBitbucketUrl]];
            NSURLRequest *nsrequest=[NSURLRequest requestWithURL:webViewURL];
            [webview loadRequest:nsrequest];
//        });
//    });
}

@end
