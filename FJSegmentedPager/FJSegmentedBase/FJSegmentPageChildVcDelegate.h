
//
//  FJSegmentPageChildVcDelegate.h
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2018/4/14.
//  Copyright © 2018年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FJSegmentPageChildVcDelegate <NSObject>

@optional

/**
 * 请注意: 如果你希望所有的子控制器的view的系统生命周期方法被正确的调用
 * 请重写父控制器的'shouldAutomaticallyForwardAppearanceMethods'方法 并且返回NO
 * 当然如果你不做这个操作, 子控制器的生命周期方法将不会被正确的调用
 * 如果你仍然想利用子控制器的生命周期方法, 请使用'FJSegmentPageChildVcDelegate'提供的代理方法
 * 或者'FJSegmentPageViewDelegate'提供的代理方法
 */


- (void)fj_viewDidLoadWithIndex:(NSInteger)index;
- (void)fj_viewWillAppearWithIndex:(NSInteger)index;
- (void)fj_viewDidAppearWithIndex:(NSInteger)index;
- (void)fj_viewWillDisappearWithIndex:(NSInteger)index;
- (void)fj_viewDidDisappearWithIndex:(NSInteger)index;
@end


@protocol FJSegmentPageViewDataSource <NSObject>

// 子页面 总数
- (NSInteger)numberOfChildViewControllers;

// 子页面 标题
- (NSArray<NSString *> *)titlesArrayOfChildViewControllers;

/** 获取到将要显示的页面的控制器
 * reuseViewController : 这个是返回给你的controller, 你应该首先判断这个是否为nil, 如果为nil 创建对应的控制器并返回, 如果不为nil直接使用并返回
 * index : 对应的下标
 */
- (UIViewController<FJSegmentPageChildVcDelegate> *)childViewController:(UIViewController<FJSegmentPageChildVcDelegate> *)reuseViewController withIndex:(NSInteger)index;

@end


@protocol FJSegmentPageViewDelegate <NSObject>


// 子页面 即将 显示
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController withIndex:(NSInteger)index;

// 子页面 已经 显示
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController withIndex:(NSInteger)index;

// 子页面 即将 消失
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController withIndex:(NSInteger)index;

// 子页面 已经 消失
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController withIndex:(NSInteger)index;
@end
