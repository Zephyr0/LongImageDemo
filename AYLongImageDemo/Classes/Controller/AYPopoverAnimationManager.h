//
//  AYPopoverAnimationManager.h
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/6.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AYPopoverAnimationManager : UIPopoverPresentationController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) CGRect preFrame;
@property (assign, nonatomic) CGFloat longImgHeight;

@end
