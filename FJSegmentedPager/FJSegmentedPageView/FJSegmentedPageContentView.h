//
//  FJDetailContentView.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSegmentPageChildVcDelegate.h"

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

// 属性 配置
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;

// 代理
@property (nonatomic, weak)  id <FJDetailContentViewDelegate> delegate;

// delegate 委托
@property (nonatomic, weak) id<FJSegmentPageViewDelegate> segmentPagedelegate;

// dataSource 数据源
@property (nonatomic, weak) id<FJSegmentPageViewDataSource> segmentPageDataSource;

// 刷新
- (void)reloadData;
// 给外界可以设置ContentOffSet的方法
- (void)setContentOffSet:(CGPoint)offset animated:(BOOL)animated ;
@end
