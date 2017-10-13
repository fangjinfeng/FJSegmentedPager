//
//  FJTitleTagSectionView.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJSegmentedTagTitleView;
// 代理
@protocol FJTitleTagSectionViewDelegate <NSObject>
// 当前 点击 index
- (void)titleSectionView:(FJSegmentedTagTitleView *)titleSectionView clickIndex:(NSInteger)index;

@end

@interface FJSegmentedTagTitleView : UIView
// item size
@property (nonatomic, assign) CGSize tagItemSize;
// 指示器 高度
@property (nonatomic, assign) CGFloat indicatorHeight;
// 指示器 宽度
@property (nonatomic, assign) CGFloat indicatorWidth;
// 标题 数据 数组
@property (nonatomic, strong) NSArray *tagTitleArray;
// 选中 索引
@property (nonatomic, assign) NSUInteger selectedIndex;
// 标题 栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// 代理
@property (nonatomic, weak)   id <FJTitleTagSectionViewDelegate> delegate;

// 更新 指示器 值
- (void)updateIndicatorView:(CGFloat)contentOffsetX;
@end
