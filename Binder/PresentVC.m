//
//  PresentVC.m
//  Int20H
//
//  Created by User on 04.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "PresentVC.h"

#import "LoginVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PresentVC ()

@end

@implementation PresentVC

#pragma mark - Class Methods (Public)

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

#pragma mark - Setters (Public)

#pragma mark - Getters (Public)

#pragma mark - Setters (Private)

#pragma mark - Getters (Private)

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *hexString = [NSString stringWithFormat:@"0077b5"];
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    UIColor *soBlueColor = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    
    self.theLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, 96, self.view.frame.size.width / 2, self.view.frame.size.height / 4)];
//    self.theLogoImageView.image = [UIImage imageNamed:@"logo"];
    NSURL *theLogoUrl = [[NSBundle mainBundle] URLForResource:@"logo" withExtension:@"png"];
    [self.theLogoImageView sd_setImageWithURL:theLogoUrl];
    [self.view addSubview:self.theLogoImageView];
    
    self.theAppNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - (self.view.frame.size.width / 7), self.theLogoImageView.frame.size.height / 7 + 96 + self.theLogoImageView.frame.size.height, self.view.frame.size.width / 3, 30)];
    self.theAppNameLabel.text = @"binder";
    self.theAppNameLabel.font = [UIFont boldSystemFontOfSize:32];
    self.theAppNameLabel.textColor = soBlueColor;
    [self.view addSubview:self.theAppNameLabel];
    
    self.theLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 10, self.view.frame.size.height - 146, self.view.frame.size.width - (self.view.frame.size.width / 5), 50)];
    [self.theLoginButton addTarget:self action:@selector(actionLoginButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.theLoginButton setBackgroundColor:soBlueColor];
    [self.theLoginButton setTitle:@"Sign Up via LinkedIn" forState:UIControlStateNormal];
    self.theLoginButton.layer.cornerRadius = self.theLoginButton.frame.size.height / 3;
    self.theLoginButton.layer.masksToBounds = YES;
    self.theLoginButton.layer.borderWidth = 0;
    self.theLoginButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:self.theLoginButton];
    
    self.theAdditionalLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, self.view.frame.size.height - (self.view.frame.size.height / 7) - 146, self.view.frame.size.width - 24, 50)];
    self.theAdditionalLabel.textColor = soBlueColor;
    self.theAdditionalLabel.textAlignment = NSTextAlignmentCenter;
    self.theAdditionalLabel.numberOfLines = 0;
    self.theAdditionalLabel.text = @"Start to expand your contact list\nas easy as possible";
    [self.view addSubview:self.theAdditionalLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - Create Views & Variables

#pragma mark - Actions

- (void)actionLoginButtonDidPressed:(UIButton *)theButton
{
    LoginVC *theLoginVC= [[UIStoryboard storyboardWithName:@"LoginStory" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginStory"];
    [self.navigationController pushViewController:theLoginVC animated:YES];
}

#pragma mark - Gestures

#pragma mark - Delegates ()

#pragma mark - Methods (Public)

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

@end






























