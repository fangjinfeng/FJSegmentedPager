//
//  FJDetailContentView.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJSegmentedPageContentView;
@class FJSegmentdPageViewController;

@protocol FJDetailContentViewDelegate <NSObject>
// 滚动 代理
- (void)detailContentView:(FJSegmentedPageContentView *)detailContentView currentIndex:(NSInteger)currentIndex;

@end

@interface FJSegmentedPageContentView : UIView
// 选中 索引
@property (nonatomic, assign) NSInteger selectedIndex;

// baseViewControllerParam 参数
@property (nonatomic, strong) id baseViewControllerParam;
// 标题 栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// 内容 viewArray
@property (nonatomic, strong) NSArray *detailContentViewArray;

// viewController Array
@property (nonatomic, strong) NSMutableArray <FJSegmentdPageViewController *>*viewControllerArray;
// 代理
@property (nonatomic, weak)  id <FJDetailContentViewDelegate> delegate;
@end
