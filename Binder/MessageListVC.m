//
//  MessageListVC.m
//  Int20H
//
//  Created by User on 05.03.17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "MessageListVC.h"

#import "PeopleViewCell.h"
#import "PeopleViewController.h"
#import "BZExtensionsManager.h"

static NSString * const cellIdentifier2 = @"cellIdentifier2";

@interface MessageListVC () {
    PeopleViewCell *cell;
    UITableView *table;
}

@end

@implementation MessageListVC

- (void)viewDidLoad {
    UITableView *theTableView = [UITableView new];
    [self.view addSubview:theTableView];
    theTableView.theWidth = theTableView.superview.theWidth;
    theTableView.theHeight = theTableView.superview.theHeight;
    table = theTableView;
    table.delegate = self;
    table.dataSource = self;
    [table registerClass:[PeopleViewCell class] forCellReuseIdentifier:cellIdentifier2];

    //[self.view addSubview:table];
    [super viewDidLoad];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2
                                           forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[PeopleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
    }
    [cell configureCellWithItem];
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"Boris Zinkovich";
        cell.detailedText.text = @"IOS developer";
        cell.distance.text = @"Integrated Techical Ltd";
        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAghAAAAJGUxMTIzMzNjLTM3NGYtNDE0YS04OTI4LTBhOGZiMTYyNTAxYQ.jpg"];
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text = @"Karina Shapran";
        cell.detailedText.text = @"UI/UX Designer";
        cell.distance.text = @"Intellabridge";
        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAgtAAAAJGU0ZWI4ZjNkLWNmOTAtNDEwMy1hM2I4LWI2MjUwMmNiM2I0Mg.jpg"];
    }
    if (indexPath.row == 2) {
        cell.nameLabel.text = @"Andrii Kovtun";
        cell.detailedText.text = @"Android developer";
        cell.distance.text = @"Integrated Techical Ltd";
        [cell configureImageWithURL:@"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAnWAAAAJDUzNTFhZjk0LWYwNDMtNDdjNy05MDk0LWViNjVhNjllODgzZQ.jpg"];
    }

    cell.detailedText.alpha = 0;
    cell.distance.alpha = 0;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.companyImageView.alpha = 0;
    UILabel *detailedText = [[UILabel alloc] initWithFrame:CGRectMake(94, 40, cell.frame.size.width - 134, 16)];
    detailedText.font = [detailedText.font fontWithSize:14];
    UIColor *soBlueColor = [UIColor getColorWithHexString:@"0077b5"];
    
    BOOL hasButton = NO;
    BOOL isRedButton = NO;
    if(indexPath.row == 0) {
        detailedText.text = [NSString stringWithFormat:@"Accepted your bind!"];
        detailedText.textColor = soBlueColor;
        hasButton = YES;
        isRedButton = NO;
    }
    if(indexPath.row == 1) {
        detailedText.text = [NSString stringWithFormat:@"Haven't accepted yet."];
        detailedText.textColor = [UIColor grayColor];
    }
    if(indexPath.row == 2) {
        detailedText.text = [NSString stringWithFormat:@"Denied your bind."];
        detailedText.textColor = [UIColor redColor];
        hasButton = YES;
        isRedButton = YES;
    }
    
    if (hasButton)
    {
        UIImageView *theView = [UIImageView new];
        [cell.contentView addSubview:theView];
        theView.theWidth = 20;
        theView.theHeight = 20;
        theView.theMaxX = [UIScreen mainScreen].bounds.size.width - 15;
        theView.theCenterY = 40;
        theView.layer.cornerRadius = theView.theWidth / 2;
        
        UILabel *theNumberLabel = [UILabel new];
        [theView addSubview:theNumberLabel];
        theNumberLabel.text = @"1";
        [theNumberLabel sizeToFit];
        theNumberLabel.theCenterY = theNumberLabel.superview.theHeight / 2;
        theNumberLabel.theCenterX = theNumberLabel.superview.theWidth / 2;
        theNumberLabel.textColor =[UIColor whiteColor];
        
        if (isRedButton)
        {
            theView.backgroundColor = [UIColor redColor];
        }
        else
        {
            theView.backgroundColor = soBlueColor;
        }
    }
    [cell addSubview:detailedText];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    MessagesVC *vc = [MessagesVC messagesViewController];
//    vc.cellData = [people.arrayWithPosts objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end






























