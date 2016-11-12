//
//  AYPresentedViewController.m
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/5.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import "AYPresentedViewController.h"

@interface AYPresentedViewController ()

@end

@implementation AYPresentedViewController

#pragma mark - 懒加载

- (UIImageView *)imageView {
    if (!_imageView) {
        NSString *path = [[NSBundle mainBundle] pathForResource:_imageName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        UIImage *newImage = [image scaleImageWithWidth:AYScreemWidth];
        _imageView = [[UIImageView alloc] initWithImage:newImage];
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [_scrollView addSubview:self.imageView];
        _scrollView.contentSize = self.imageView.frame.size;
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisspresentedController)];
    [self.view addGestureRecognizer:tapGes];
//    NSLog(@"%s",__func__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.imageView removeFromSuperview];
    [self.view addSubview:self.scrollView];
//    NSLog(@"%s",__func__);
}

- (void)dismisspresentedController {
    [self.scrollView removeFromSuperview];
    [self.view addSubview:self.imageView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
