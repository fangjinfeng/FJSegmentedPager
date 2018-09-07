//
//  UIViewController+FJCurrentViewController.h
//  FJPhotoBrowserDemo
//
//  Created by fjf on 2017/7/28.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FJCurrentViewController)
@property (nonatomic, assign) NSInteger fj_currentIndex;
// 查找 当前 控制器
+ (UIViewController *)fj_currentViewController;
// 找到 navigation topViewController
+ (UIViewController *)fj_navigationTopViewController;
// 找到 viewController
+ (UIViewController*)fj_findBestViewController:(UIViewController*)vc;
@end
