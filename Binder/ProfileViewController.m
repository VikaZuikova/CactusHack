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
    NSString *theUrl = [NSString stringWithFormat:@"%@", _theUser == nil ? [AppDelegate sharedInstance].theConfig.theUser.theLinkedInProfileUrl : _theUser.theLinkedInProfileUrl];
    NSURL *webViewURL = [NSURL URLWithString:theUrl];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:webViewURL];
    [webview loadRequest:nsrequest];
}

@end
