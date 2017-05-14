//
//  PeopleViewController.m
//  Int20H
//
//  Created by Ilya on 4/3/17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "PeopleViewController.h"

#import "MessagesVC.h"
#import "PeopleViewCell.h"
#import "User.h"
#import "PeopleViewController.h"
#import "GetNearbyUsersTask.h"
#import "AppConfig.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"

#import "BZExtensionsManager.h"

static NSString * const cellIdentifier = @"peopleCell";

@interface PeopleViewController ()<UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *theController;
@property (nonatomic, strong, nullable) NSArray<User *> *theUserList;
@property (nonatomic, strong) GetNearbyUsersTask *theNearbyTask;

@end

@implementation PeopleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tablePeopleView.delegate = self;
    self.tablePeopleView.dataSource = self;
    self.navigationItem.title = @"People nearby";
    
    UISearchController *theController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.theController = theController;
    theController.searchResultsUpdater = self;
    theController.searchBar.delegate = self;
    theController.dimsBackgroundDuringPresentation = YES;
    [theController.searchBar sizeToFit];
    self.tablePeopleView.tableHeaderView = theController.searchBar;
    
    self.theNearbyTask = [[GetNearbyUsersTask alloc] initWithCurrentUser:[AppDelegate sharedInstance].theConfig.theUser];
    [self.theNearbyTask methodStartWithUpdatedBlock:^(NSArray<User *> * _Nonnull theNewList)
    {
        [BZExtensionsManager methodAsyncMainWithBlock:^
        {
            self.theUserList = theNewList;
            [self.tablePeopleView reloadData];
        }];
    }
                                        withFailure:^(NSError * _Nonnull theError)
    {
        
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.theUserList == nil ? 0 : self.theUserList.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                           forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[PeopleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell configureCellWithItem];
    User *theCurrentUser = self.theUserList[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", theCurrentUser.theName, theCurrentUser.theLastName];
    cell.detailedText.text = theCurrentUser.thePosition;
    cell.distance.text = theCurrentUser.theCompany;
    [cell configureImageWithURL:theCurrentUser.theUserPuctureUrl];
    
//    if (indexPath.row == 0) {
//        cell.nameLabel.text = @"Boris Zinkovich";
//        cell.detailedText.text = @"IOS developer";
//        cell.distance.text = @"Integrated Techical Ltd";
//        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAghAAAAJGUxMTIzMzNjLTM3NGYtNDE0YS04OTI4LTBhOGZiMTYyNTAxYQ.jpg"];
//    }
//    if (indexPath.row == 1) {
//        cell.nameLabel.text = @"Karina Shapran";
//        cell.detailedText.text = @"UI/UX Designer";
//        cell.distance.text = @"Intellabridge";
//        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAgtAAAAJGU0ZWI4ZjNkLWNmOTAtNDEwMy1hM2I4LWI2MjUwMmNiM2I0Mg.jpg"];
//    }
//    if (indexPath.row == 2) {
//        cell.nameLabel.text = @"Andrii Kovtun";
//        cell.detailedText.text = @"Android developer";
//        cell.distance.text = @"Integrated Techical Ltd";
//        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAnWAAAAJDUzNTFhZjk0LWYwNDMtNDdjNy05MDk0LWViNjVhNjllODgzZQ.jpg"];
//    }
//    if (indexPath.row == 3) {
//        cell.nameLabel.text = @"Ilya Gorevoy";
//        cell.detailedText.text = @"Chinese Teacher";
//        cell.distance.text = @"Kyiv Polytechnic Institute";
//        [cell configureImageWithURL:@"https://www.linkedin.com/mpr/mpr/p/6/005/0a1/09b/30842a3.jpg"];
//    }
//    if (indexPath.row == 4) {
//        cell.nameLabel.text = @"Bogdan Stepanyuk";
//        cell.detailedText.text = @"Android developer";
//        cell.distance.text = @"Polytech Soft";
//        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAksAAAAJGYwY2JlOTA0LWRjMjgtNDhlNC05ODI1LWY5ODJhMzEzNzZmMg.jpg"];
//    }
//    if (indexPath.row == 5) {
//        cell.nameLabel.text = @"Elizaveta Prokhorova";
//        cell.detailedText.text = @"IT Recruiter";
//        cell.distance.text = @"EVO.company";
//        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAXaAAAAJDY3ZTVjZThmLTBlMDEtNDY3Yy1iZTU4LWU1ZDk5Zjk1ZDNhNw.jpg"];
//    }
//    if (indexPath.row == 6) {
//        cell.nameLabel.text = @"Vladimir Karatieiev";
//        cell.detailedText.text = @"CEO";
//        cell.distance.text = @"ECS-3.COM";
//        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/7/005/080/33b/25f5f1b.jpg"];
//    }
//    if (indexPath.row == 7) {
//        cell.nameLabel.text = @"Oleksandr Kovalchuk";
//        cell.detailedText.text = @"Junior Python Developer";
//        cell.distance.text = @"Prom.ua";
//        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAhAAAAAJDU3NWEwYmRjLWJmMzgtNDAyMS05OWM3LTZjNGNjODk0YmFkZg.jpg"];
//    }
//    if (indexPath.row == 8) {
//        cell.nameLabel.text = @"Anastasiia Kovtun";
//        cell.detailedText.text = @"Recruitment Partner";
//        cell.distance.text = @"RINF TECH";
//        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAiFAAAAJGFjODcyM2JlLTRlNGQtNDAwZi04M2Q0LWMyYWM0MTQ1MDg1Yg.jpg"];
//    }

    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ProfileViewController *theVC = [ProfileViewController new];
    theVC.theUser = self.theUserList[indexPath.row];
    [self.navigationController pushViewController:theVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MessagesVC *vc = [MessagesVC messagesViewController];
    vc.theSenderName = ((PeopleViewCell *)[tableView cellForRowAtIndexPath:indexPath]).nameLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.theController.active = NO;

}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end






























