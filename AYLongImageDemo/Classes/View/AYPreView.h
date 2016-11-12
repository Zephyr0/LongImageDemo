//
//  AYPreView.h
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/6.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AYPreView;
@protocol AYPreViewDelegate <NSObject>

- (void)preView:(AYPreView *)preView didTappedWithTapGes:(UITapGestureRecognizer *)tapGes;

@end

@interface AYPreView : UIImageView

@property (copy, nonatomic) NSString *imgName;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) id<AYPreViewDelegate> delegate;

+ (instancetype)preView;

@end
