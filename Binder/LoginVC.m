//
//  LoginVC.m
//  Int20H
//
//  Created by User on 04.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "LoginVC.h"

#import "UserDefaults.h"
#import "BZURLSession.h"

#import "BZExtensionsManager.h"

@interface LoginVC () <UIWebViewDelegate>

@end

NSString * const keyLoginURLString = @"https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=863tfcxornvc9j&redirect_uri=https://vk.com/int20h_2016&state=sMwTBsaRtCVTXZr9&scope=r_basicprofile";
NSString * const keyCodeString = @"code";

@implementation LoginVC

#pragma mark - Class Methods (Public)

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

#pragma mark - Setters (Public)

#pragma mark - Getters (Public)

#pragma mark - Setters (Private)

#pragma mark - Getters (Private)

#pragma mark - Lifecycle

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.theMainWebView.delegate = self;
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:keyLoginURLString]];
    [self.theMainWebView loadRequest:theRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Create Views & Variables

#pragma mark - Actions

#pragma mark - Gestures

#pragma mark - Delegates (UIWebViewDelegate)

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *theURLString = request.URL.absoluteString;
    if ([theURLString containsString:@"https://vk.com/int20h_2016"])
    {
        if ([theURLString containsString:@"code"])
        {
            NSArray *thePairArray = [theURLString componentsSeparatedByString:@"?"];
            if (!thePairArray.count)
            {
                return YES;
            }
            theURLString = thePairArray.lastObject;
             NSArray *theParametersArray = [theURLString componentsSeparatedByString:@"&"];
            for (NSString *theParameterString in theParametersArray)
            {
                NSArray *thePairArray = [theParameterString componentsSeparatedByString:@"="];
                NSString *theKeyString = thePairArray.firstObject;
                if (isEqual(theKeyString, keyCodeString))
                {
                    NSLog(@"%@", theURLString);
                    NSLog(@"%@", thePairArray.lastObject);
                    [self methodStartProfileTask:thePairArray.lastObject];
                    return NO;
                }
            }
        }
        return YES;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.theActivityIndicatorView.alpha = 1;
    [self.theActivityIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.theActivityIndicatorView.alpha = 0;
    [self.theActivityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nonnull NSError *)error
{
    self.theActivityIndicatorView.alpha = 0;
    [self.theActivityIndicatorView stopAnimating];
}

#pragma mark - Methods (Public)

#pragma mark - Methods (Private)

- (void)methodStartProfileTask:(NSString *)theCode
{
    BZURLSession *theSession = [BZURLSession new];
    NSDictionary *theDict = [NSDictionary dictionaryWithObjectsAndKeys:@"authorization_code", @"grant_type", theCode, keyCodeString, @"https://vk.com/int20h_2016", @"redirect_uri", @"863tfcxornvc9j", @"client_id", @"sMwTBsaRtCVTXZr9", @"client_secret", nil];
    NSLog(@"%@", theDict);
    NSData *thePostData = [NSJSONSerialization dataWithJSONObject:theDict options:0 error:nil];
    [theSession methodStartPostTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.linkedin.com/oauth/v2/accessToken?client_id=863tfcxornvc9j&client_secret=sMwTBsaRtCVTXZr9&redirect_uri=https://vk.com/int20h_2016&grant_type=authorization_code&code=%@", theCode]] withPostData:thePostData progressBlock:nil completionBlockWithData:^(NSData * _Nullable data, NSError * _Nullable theError)
     {
         NSDictionary *theResultDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:&theError];
         NSLog(@"%@", theResultDictionary);
         NSString *theStr = theResultDictionary[@"access_token"];
         NSLog(@"%@", theStr);
         [UserDefaults sharedInstance].theAccessToken = theStr;
         [self dismissViewControllerAnimated:YES completion:nil];
     }];

}

#pragma mark - Standard Methods

@end


























