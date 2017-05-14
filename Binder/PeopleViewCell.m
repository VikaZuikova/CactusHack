//
//  PeopleViewCell.m
//  Int20H
//
//  Created by Ilya on 4/3/17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import "PeopleViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface PeopleViewCell ()

@property (nonatomic, assign) BOOL isFirst;

@end
@implementation PeopleViewCell

- (void) configureCellWithItem {
    if (_isFirst) {
        return;
    }
    _isFirst = YES;
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 4, 70, 70)];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height /2;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.borderWidth = 0;
    [self addSubview:self.avatarImageView];
//    NSURL *avatarImageURL = [NSURL URLWithString:[arrayCell objectForKey:@"imageURL"]];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
//                   {
//                       NSData *data = [NSData dataWithContentsOfURL:avatarImageURL];
//                       
//                       dispatch_async(dispatch_get_main_queue(), ^{
//                           self.imageView.image = [UIImage imageWithData:data];
//                       });
//                   });
//    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 12, self.frame.size.width - 134, 22)];
    self.nameLabel.font = [self.nameLabel.font fontWithSize:20];
    [self addSubview:self.nameLabel];
//    NSString *nameString = [NSString stringWithFormat:@"%@ %@", [arrayCell objectForKey:@"firstName"], [arrayCell objectForKey:@"lastName"]];
//    self.textLabel.text = nameString;
  
    self.detailedText = [[UILabel alloc] initWithFrame:CGRectMake(94, 34, self.frame.size.width - 134, 16)];
    self.detailedText.font = [self.detailedText.font fontWithSize:14];
    [self addSubview:self.detailedText];
    
    UIImageView *companyImage = [[UIImageView alloc] initWithFrame:CGRectMake(94, 48, 16, 20)];
    self.companyImageView = companyImage;
    companyImage.image = [UIImage imageNamed:@"company"];
    [self addSubview:companyImage];
    self.distance = [[UILabel alloc] initWithFrame:CGRectMake(112, 48, self.frame.size.width - 134, 20)];
    self.distance.font = [self.distance.font fontWithSize:14];
    self.distance.textColor = [UIColor grayColor];
    [self addSubview:self.distance];
    self.accessoryType = UITableViewCellAccessoryDetailButton;
//    self.detailTextLabel.text = [arrayCell objectForKey:@"headline"];
//    
//    self.idOfUser = [NSString stringWithFormat:@"%@", [arrayCell objectForKey:@"id"]];
//    self.profileURL = [NSString stringWithFormat:@"%@", [arrayCell objectForKey:@"url"]];
//    
}

- (void) configureImageWithURL:(NSString *)imageURL
{
    NSURL *avatarImageURL = [NSURL URLWithString:imageURL];
    [self.avatarImageView sd_setImageWithURL:avatarImageURL placeholderImage:nil];
    
}

//"firstName": "Boris",
//"headline": "IOS developer – Integrated Techical Vision Ltd.",
//"id": "092D2JeyNp",
//"lastName": "Zinkovich",
//"siteStandardProfileRequest": {
//    "url": "https://www.linkedin.com/profile/view?id=AAoAABoSfe8B..*a3227641*s3301901*"
//}
//imageURL: url
@end
