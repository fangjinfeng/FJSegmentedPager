//
//  FJTitleTagSectionView.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJSegmentViewStyle;
@class FJSegmentedTagTitleView;

// 代理
@protocol FJTitleTagSectionViewDelegate <NSObject>
// 当前 点击 index
- (void)titleSectionView:(FJSegmentedTagTitleView *)titleSectionView clickIndex:(NSInteger)index;

@end

@interface FJSegmentedTagTitleView : UIView

// 标题 数据 数组
@property (nonatomic, strong) NSArray *tagTitleArray;
// 选中 索引
@property (nonatomic, assign) NSUInteger selectedIndex;
// 属性 配置
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;
// 代理
@property (nonatomic, weak)   id <FJTitleTagSectionViewDelegate> delegate;

@end
