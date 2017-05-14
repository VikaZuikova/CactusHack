//
//  MainTabBarVC.m
//  Int20H
//
//  Created by User on 04.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "MainTabBarVC.h"

#import "MessagesVC.h"
#import "ProfileViewController.h"
#import "UserDefaults.h"
#import "PresentVC.h"
#import "PeopleViewController.h"
#import "MessageListVC.h"
#import "User.h"
#import "AppConfig.h"
#import "AppDelegate.h"

#import "BZExtensionsManager.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <Firebase/Firebase.h>

@interface MainTabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic, strong, nullable) User *theUser;

@end

@implementation MainTabBarVC

#pragma mark - Class Methods (Public)

+ (MainTabBarVC * _Nonnull)sharedInstance
{
    static MainTabBarVC *theMainTabBarController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      theMainTabBarController = [[MainTabBarVC alloc] initSharedInstance];
                  });
    return theMainTabBarController;
}

- (instancetype)initSharedInstance
{
    self  = [super init];
    if (self)
    {
        
    }
    return self;
}

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
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isFirstLoad)
    {
        [self createAllViews];
    }
}

- (void)createAllViews
{
    if (!self.isFirstLoad)
    {
        return;
    }
    self.isFirstLoad = NO;
    //    self.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.delegate = self;
    NSMutableArray *theViewControllersMutableArray = [NSMutableArray new];
    
    double theBarImageSize = 32;
    int offset = 5;
    UIEdgeInsets imageInset = UIEdgeInsetsMake(offset, 0, -offset, 0);

    MessageListVC *vc = [MessageListVC new];
    UINavigationController *theMessagesVCNav = [[UINavigationController alloc] initWithRootViewController:vc];
    UITabBarItem *theMessagesTabBarItem = [[UITabBarItem alloc]
                                           initWithTitle:nil
                                           image:[UIImage imageWithImage:[UIImage getImageNamed:@"message"]  scaledToSize:CGSizeMake(theBarImageSize, theBarImageSize)]
                                           tag:2];
    theMessagesVCNav.tabBarItem = theMessagesTabBarItem;
    [theViewControllersMutableArray addObject:theMessagesVCNav];
    theMessagesVCNav.tabBarItem.imageInsets = imageInset;

    PeopleViewController *peopleViewController = [[UIStoryboard storyboardWithName:@"PeopleView" bundle:nil] instantiateViewControllerWithIdentifier:@"peopleStory"];
    UINavigationController *thePeopleVCNav = [[UINavigationController alloc] initWithRootViewController:peopleViewController];
    UITabBarItem *thePeopleTabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageWithImage:[UIImage getImageNamed:@"people"]  scaledToSize:CGSizeMake(theBarImageSize, theBarImageSize)] tag:0];
    thePeopleVCNav.tabBarItem = thePeopleTabBarItem;
    [theViewControllersMutableArray addObject:thePeopleVCNav];
    thePeopleVCNav.tabBarItem.imageInsets = imageInset;

    ProfileViewController *theProfileVC = [ProfileViewController new];
    UINavigationController *theProfileVCNav = [[UINavigationController alloc] initWithRootViewController:theProfileVC];
    UITabBarItem *theLogListItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageWithImage:[UIImage getImageNamed:@"profile"]  scaledToSize:CGSizeMake(theBarImageSize, theBarImageSize)]tag:2];
    theProfileVCNav.tabBarItem = theLogListItem;
    [theViewControllersMutableArray addObject:theProfileVCNav];
    theProfileVCNav.tabBarItem.imageInsets = imageInset;

    [self setViewControllers:theViewControllersMutableArray animated:NO];
    
    [self setSelectedIndex:1];
    
    self.theUser = [AppDelegate sharedInstance].theConfig.theUser;
    if (!self.theUser)
    {
        PresentVC *thePresentVC= [[UIStoryboard storyboardWithName:@"PresentVCStory" bundle:nil] instantiateViewControllerWithIdentifier:@"PresentVCStory"];
        UINavigationController *theNvVC = [[UINavigationController alloc] initWithRootViewController:thePresentVC];
        [self.navigationController presentViewController:theNvVC animated:YES completion:nil];
    }
}

#pragma mark - Actions

#pragma mark - Gestures

#pragma mark - Delegates ()

#pragma mark - Methods (Public)

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

@end


























