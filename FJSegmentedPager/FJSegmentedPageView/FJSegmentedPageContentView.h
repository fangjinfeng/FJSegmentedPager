//
//  FJDetailContentView.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJSegmentViewStyle;
@class FJSegmentedPageContentView;
@class FJSegmentdPageViewController;

@protocol FJDetailContentViewDelegate <NSObject>

// 滚动 过程
- (void)detailContentView:(FJSegmentedPageContentView *)detailContentView
            previousIndex:(NSInteger)previousIndex
             currentIndex:(NSInteger)currentIndex
                 progress:(CGFloat)progress;

// 滚动 代理
- (void)detailContentView:(FJSegmentedPageContentView *)detailContentView currentIndex:(NSInteger)currentIndex;

@end

@interface FJSegmentedPageContentView : UIView

// 选中 索引
@property (nonatomic, assign) NSInteger selectedIndex;

// baseViewControllerParam 参数
@property (nonatomic, strong) id baseViewControllerParam;

// 内容 viewArray
@property (nonatomic, strong) NSArray *detailContentViewArray;

// 属性 配置
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;

// 代理
@property (nonatomic, weak)  id <FJDetailContentViewDelegate> delegate;

// viewController Array
@property (nonatomic, strong) NSMutableArray <FJSegmentdPageViewController *>*viewControllerArray;
@end
