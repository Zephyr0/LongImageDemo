//
//  AYPopoverAnimationManager.m
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/6.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import "AYPopoverAnimationManager.h"

@interface AYPopoverAnimationManager ()

@property (assign, nonatomic, getter=isPresent) BOOL present;

@end

@implementation AYPopoverAnimationManager

#pragma mark - UIViewControllerTransitioningDelegate

/**
 告诉系统谁负责自定义转场

 @param presented 需要展现的VC
 @param presenting 现在的VC
 @param source 源VC
 @return 负责自定义转场的VC
 */
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return self;
}

/**
 告诉系统谁负责转场动画

 @param presented 需要展现的VC
 @param presenting 当前的VC
 @param source 源VC
 @return 负责转场动画的VC
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

/**
 告诉系统谁负责消失动画

 @param dismissed 需要消失的VC
 @return 负责消失动画的VC
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

/**
 自定义转场动画的时间

 @param transitionContext 自定义转场动画的上下文
 @return 转场动画的时间
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

/**
 自定义转场动画

 @param transitionContext 自定义转场动画的上下文
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 通过 key 取到 fromVC 和 toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 把 toVC 加入到 containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    // 一些动画要用的的数据
//    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGFloat posX = AYScreemWidth / 2;
    CGFloat posY = _preFrame.origin.y + _preFrame.origin.y / AYScreemHeight * _preFrame.size.height;
    CGFloat anchorRatioY = posY / AYScreemHeight;
    // 动画过程
    if (toVC.isBeingPresented) {
        //        toVC.view.frame = CGRectOffset(finalFrame, 0, -finalFrame.size.height);
        CGFloat preTransRatioX = _preFrame.size.width / AYScreemWidth;
        CGFloat preTransRatioY = _preFrame.size.height / AYScreemHeight;
        toVC.view.transform = CGAffineTransformMakeScale(preTransRatioX, preTransRatioY);
        toVC.view.layer.position = CGPointMake(posX, posY);
        toVC.view.layer.anchorPoint = CGPointMake(0.5, anchorRatioY);
        [UIView animateWithDuration:duration
                         animations:^{
                             //                             toVC.view.frame = finalFrame;
                             toVC.view.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             // 结束后要通知系统
                             [transitionContext completeTransition:YES];
                         }];
    }
    
    if (fromVC.isBeingDismissed) {
        [containerView sendSubviewToBack:toVC.view];
        fromVC.view.layer.position = CGPointMake(posX, posY);
        fromVC.view.layer.anchorPoint = CGPointMake(0.5, anchorRatioY);
        // 消失动画
        [UIView animateWithDuration:duration
                         animations:^{
                             CGFloat xRatio = _preFrame.size.width / AYScreemWidth;
                             CGFloat yRatio = _preFrame.size.height / _longImgHeight;
                             fromVC.view.transform = CGAffineTransformMakeScale(xRatio, yRatio);
                         }
                         completion:^(BOOL finished) {
                             // dismiss 动画添加了手势后可能出现转场取消的状态，所以要根据状态来判定是否完成转场
                             BOOL isComplete = ![transitionContext transitionWasCancelled];
                             [transitionContext completeTransition:isComplete];
                         }];
    }

}

@end
