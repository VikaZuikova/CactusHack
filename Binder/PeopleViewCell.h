//
//  PeopleViewCell.h
//  Int20H
//
//  Created by Ilya on 4/3/17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleViewCell : UITableViewCell

@property (strong, nonatomic)  NSString *idOfUser;
@property (strong, nonatomic)  NSString *profileURL;
@property (nonatomic) UILabel *detailedText;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UIImageView *companyImageView;
@property (nonatomic) UILabel *distance;

- (void) configureCellWithItem;
- (void) configureImageWithURL:(NSString *)imageURL;

@end





























