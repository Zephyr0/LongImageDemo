//
//  AYTableViewCell.h
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/6.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AYPreView;
@interface AYTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) AYPreView *preView;

+ (instancetype)cellWithTableView: (UITableView *)tableView;

@end
