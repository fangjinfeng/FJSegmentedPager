
//
//  UIViewController+FJCurrentViewController.m
//  FJPhotoBrowserDemo
//
//  Created by fjf on 2017/7/28.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "UIViewController+FJCurrentViewController.h"

@implementation UIViewController (FJCurrentViewController)
// 查找 当前 控制器
+ (UIViewController *)fj_currentViewController {
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController fj_findBestViewController:viewController];
}

// 找到 viewController
+ (UIViewController*)fj_findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController fj_findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController fj_findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController fj_findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController fj_findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

// 找到 navigation topViewController
+ (UIViewController *)fj_navigationTopViewController {
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)viewController;
        UIViewController *tmpNavigationController = tabbarController.selectedViewController;
        if ([tmpNavigationController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)tmpNavigationController;
            return navigationController.topViewController;
        }
    }
    return nil;
}


@end
