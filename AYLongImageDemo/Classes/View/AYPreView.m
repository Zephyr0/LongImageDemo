//
//  AYPreView.m
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/6.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import "AYPreView.h"

@implementation AYPreView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(7, 30, 400, 300);
        //手势
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentPresentedViewController:)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

+ (instancetype)preView {
    AYPreView *preView = [[self alloc] init];
    return preView;
}

- (void)presentPresentedViewController:(UITapGestureRecognizer *)tapGes {
    if ([self.delegate respondsToSelector:@selector(preView:didTappedWithTapGes:)]) {
        [self.delegate preView:self didTappedWithTapGes:tapGes];
    }
}

@end
