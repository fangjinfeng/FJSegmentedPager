//
//  FJSegmentViewStyle.h
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/11/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FJSegmentViewStyle : NSObject
// 选择 第几个 tag
@property (nonatomic, assign) NSInteger selectedIndex;
// 标题 字体
@property (nonatomic, strong) UIFont *itemTitleFont;
// 标题 栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// 标题 选中 字体
@property (nonatomic, strong) UIFont *itemTitleSelectedFont;
// 标题 分隔栏 背景色
@property (nonatomic, strong) UIColor *segmentToolbackgroundColor;
// 分段 标题 字体 普通 颜色
@property (nonatomic, strong) UIColor *itemTitleColorStateNormal;
// 分段 标题 字体 选中 颜色
@property (nonatomic, strong) UIColor *itemTitleColorStateSelected;
// 分段 标题 字体 高亮 颜色
@property (nonatomic, strong) UIColor *itemTitleColorStateHighlighted;
// 分割线 背景色
@property (nonatomic, strong) UIColor *separatorBackgroundColor;
// 指示器 背景色
@property (nonatomic, strong) UIColor *indicatorViewBackgroundColor;
// tableView 背景色
@property (nonatomic, strong) UIColor *tableViewBackgroundColor;
// 分割线 高度
@property (nonatomic, assign) CGFloat separatorLineHeight;
// 指示条 高度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewHeight;
// 指示条 宽度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewWidth;
// 指示条 默认 扩展宽度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewExtendWidth;
// 标题 默认 宽度
@property (nonatomic, assign) CGFloat segmentedTitleViewTitleWidth;
// 标题栏 cell  间距
@property (nonatomic, assign) CGFloat segmentedTagSectionCellSpacing;
// 标题栏 左右 间距
@property (nonatomic, assign) CGFloat segmentedTagSectionHorizontalEdgeSpacing;
// 消除 子类 滚动 限制
@property (nonatomic, assign, getter=isEliminateSubViewScrollLimit) BOOL eliminateSubViewScrollLimit;
@end
