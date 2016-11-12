//
//  AYPresentedViewController.h
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/5.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AYPresentedViewController : UIViewController

@property (copy, nonatomic) NSString *imageName;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end
