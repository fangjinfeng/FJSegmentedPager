//
//  FJTitleTagSectionView.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSegmentPageChildVcDelegate.h"

@class FJSegmentViewStyle;
@class FJSegmentedTagTitleView;

// 代理
@protocol FJTitleTagSectionViewDelegate <NSObject>
// 当前 点击 index
- (void)titleSectionView:(FJSegmentedTagTitleView *)titleSectionView clickIndex:(NSInteger)index;

@end

@interface FJSegmentedTagTitleView : UIView

// 选中 索引
@property (nonatomic, assign) NSUInteger selectedIndex;
// 属性 配置
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;
// 代理
@property (nonatomic, weak)   id <FJTitleTagSectionViewDelegate> delegate;

// dataSource 数据源
@property (nonatomic, weak) id<FJSegmentPageViewDataSource> segmentPageDataSource;
// 刷新 数据
- (void)reloadData;
// 依据 索引 更新 控件 状态
- (void)updateControlsStatusWithCurrentIndex:(NSInteger)currentIndex;
// 依据 参数 更新 控件
- (void)updateControlsWithPreviousIndex:(NSInteger)previousIndex currentIndex:(NSInteger)currentIndex progress:(CGFloat)progress;
@end
