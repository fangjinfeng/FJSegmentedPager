//
//  UIView+FJFrame.m
//  FJPhotoBrowserDemo
//
//  Created by fjf on 2017/7/28.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "UIView+FJFrame.h"

@implementation UIView (fjFrame)

- (CGFloat)fj_height
{
    return self.frame.size.height;
}

- (CGFloat)fj_width
{
    return self.frame.size.width;
}

- (void)setFj_height:(CGFloat)fj_height {
    CGRect frame = self.frame;
    frame.size.height = fj_height;
    self.frame = frame;
}
- (void)setFj_width:(CGFloat)fj_width {
    CGRect frame = self.frame;
    frame.size.width = fj_width;
    self.frame = frame;
}

- (CGFloat)fj_x
{
    return self.frame.origin.x;
}

- (void)setFj_x:(CGFloat)fj_x {
    CGRect frame = self.frame;
    frame.origin.x = fj_x;
    self.frame = frame;
}


- (CGFloat)fj_y
{
    return self.frame.origin.y;
}


- (void)setFj_y:(CGFloat)fj_y {
    CGRect frame = self.frame;
    frame.origin.y = fj_y;
    self.frame = frame;
}


- (void)setFj_centerX:(CGFloat)fj_centerX {
    CGPoint center = self.center;
    center.x = fj_centerX;
    self.center = center;
}

- (CGFloat)fj_centerX
{
    return self.center.x;
}


- (void)setFj_centerY:(CGFloat)fj_centerY {
    CGPoint center = self.center;
    center.y = fj_centerY;
    self.center = center;
}

- (CGFloat)fj_centerY
{
    return self.center.y;
}

@end
