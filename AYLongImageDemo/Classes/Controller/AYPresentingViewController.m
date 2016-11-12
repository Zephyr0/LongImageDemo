//
//  ViewController.m
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/5.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import "AYPresentingViewController.h"
#import "AYPresentedViewController.h"
#import "AYPopoverAnimationManager.h"
#import "AYPreView.h"
#import "AYTableViewCell.h"

@interface AYPresentingViewController ()<UITableViewDataSource, UITableViewDelegate, AYPreViewDelegate>

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> animationController;
@property (strong, nonatomic) AYPreView *preView;
@property (strong, nonatomic) NSMutableArray *longImgs;
@property (strong, nonatomic) AYPopoverAnimationManager *aniManager;
@property (strong, nonatomic) UIImage *selImg;
@property (strong, nonatomic) NSArray *imageNames;
@property (strong, nonatomic) NSMutableArray *imgSizes;
@property (strong, nonatomic) NSMutableArray *scaleSizes;
@property (strong, nonatomic) NSMutableArray *screemPoints;
@property (assign, nonatomic) CGPoint screemPoint;

@end

@implementation AYPresentingViewController

static NSString *cellIdentifier = @"cell";

#pragma mark - 懒加载

- (NSMutableArray *)screemPoints {
    if (!_screemPoints) {
        _screemPoints = [NSMutableArray array];
    }
    return _screemPoints;
}

- (NSMutableArray *)scaleSizes {
    if (!_scaleSizes) {
        _scaleSizes = [NSMutableArray array];
    }
    return _scaleSizes;
}

- (NSMutableArray *)imgSizes {
    if (!_imgSizes) {
        _imgSizes = [NSMutableArray array];
    }
    return _imgSizes;
}

- (NSMutableArray *)longImgs {
    if (!_longImgs) {
        _longImgs = [NSMutableArray array];
        _imageNames = @[@"longImg1.jpeg", @"longImg2.jpeg", @"longImg3.jpeg", @"longImg4.jpeg", @"longImg5.jpeg", @"longImg6.jpeg", @"screemShot1.jpeg", @"screemShot2.jpeg"];
        for (NSString *imgName in _imageNames) {
            NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [self.imgSizes addObject:NSStringFromCGSize(image.size)];
            UIImage *stretchedImg = [image scaleImageWithWidth:self.preView.width];
            [self.scaleSizes addObject:NSStringFromCGSize(stretchedImg.size)];
            [_longImgs addObject:stretchedImg];
        }
    }
    return _longImgs;
}

- (UIImageView *)preView {
    if (!_preView) {
        _preView = [AYPreView preView];
    }
    return _preView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"大图Demo";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - TableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.longImgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AYTableViewCell *cell = [AYTableViewCell cellWithTableView:tableView];
    cell.preView.image = self.longImgs[indexPath.row];
    cell.preView.imgName = self.imageNames[indexPath.row];
    cell.preView.indexPath = indexPath;
    cell.preView.delegate = self;
    cell.titleLabel.text = [NSString stringWithFormat:@"原始尺寸：%@ 改变后的尺寸：%@", self.imgSizes[indexPath.row], self.scaleSizes[indexPath.row]];
    return cell;
}

#pragma mark - TableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.preView.y + self.preView.height + 10;
}

#pragma mark - AYPreView delegate

- (void)preView:(AYPreView *)preView didTappedWithTapGes:(UITapGestureRecognizer *)tapGes {
    
    AYPresentedViewController *presentedVC = [[AYPresentedViewController alloc] init];
    
    presentedVC.imageName = preView.imgName;
    NSString *path = [[NSBundle mainBundle] pathForResource:presentedVC.imageName ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImage *stretchedImage = [image scaleImageWithWidth:AYScreemWidth];
    
    AYTableViewCell *cell = [self.tableView cellForRowAtIndexPath:preView.indexPath];
    CGFloat currentX = preView.x;
    CGFloat currentY = cell.y - self.tableView.contentOffset.y + preView.y;
    
    AYPopoverAnimationManager *manager = [[AYPopoverAnimationManager alloc] initWithPresentedViewController:presentedVC presentingViewController:self];
    
//    NSLog(@"preView -> screemPoint: %@", NSStringFromCGPoint(preView.screemPoint));
    
    manager.preFrame = (CGRect){{currentX, currentY}, preView.frame.size};
    manager.longImgHeight = stretchedImage.size.height;
    presentedVC.transitioningDelegate = manager;
    presentedVC.modalPresentationStyle = UIModalPresentationCustom;
    [presentedVC.view addSubview:presentedVC.imageView];
    [self presentViewController:presentedVC animated:YES completion:nil];
}

@end
