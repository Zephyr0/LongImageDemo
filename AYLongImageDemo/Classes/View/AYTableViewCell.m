//
//  AYTableViewCell.m
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/6.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import "AYTableViewCell.h"
#import "AYPreView.h"

static NSString *cellID = @"cell";

@implementation AYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    AYTableViewCell *cell = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    AYPreView *preView = [AYPreView preView];
    cell.preView = preView;
    [cell addSubview:preView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, AYScreemWidth, 30)];
    [cell addSubview:titleLabel];
    cell.titleLabel = titleLabel;
    
    UILabel *blackLabel = [[UILabel alloc] initWithFrame:CGRectMake(preView.x, 300, preView.width, 30)];
    blackLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    blackLabel.textColor = [UIColor whiteColor];
    blackLabel.text = @"点击查看大图";
    blackLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:blackLabel];
    
    cell.backgroundColor = [UIColor colorWithRed: 255 / 255.0 green: 185 / 255.0 blue: 80 / 255.0 alpha:1];
    
    return cell;
}

+ (instancetype)cellWithTableView:(id)tableView {
    AYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

@end
