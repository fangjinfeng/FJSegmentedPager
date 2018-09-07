//
//  FJSegementContentView
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSegmentPageChildVcDelegate.h"


@class FJConfigModel;
@class FJSegmentViewStyle;

@interface FJSegementPageView : UIView

// delegate 委托
@property (nonatomic, weak) id<FJSegmentPageViewDelegate> delegate;

// dataSource 数据源
@property (nonatomic, weak) id<FJSegmentPageViewDataSource> dataSource;

// 属性 配置 (必须为第一个传入参数)
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;

// 刷新
- (void)reloadData;
// 设置 选中 索引
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
- (NSInteger)selectedIndex;
@end
