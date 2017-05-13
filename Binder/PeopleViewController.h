//
//  PeopleViewController.h
//  Int20H
//
//  Created by Ilya on 4/3/17.
//  Copyright © 2017 ZBY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleViewCell.h"

@interface PeopleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tablePeopleView;
@property (nonatomic) NSArray *arrayWithPosts;

@end






























