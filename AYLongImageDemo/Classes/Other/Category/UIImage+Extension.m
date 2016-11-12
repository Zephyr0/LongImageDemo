//
//  UIImage+Extension.m
//  AYLongImageDemo
//
//  Created by Zephyr on 2016/11/5.
//  Copyright © 2016年 Zephyr. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)scaleImageWithWidth:(float)width {
    CGFloat ratio = self.size.height / self.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(width, width * ratio));
    [self drawInRect:CGRectMake(0, 0, width, width *ratio)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
    }

@end
