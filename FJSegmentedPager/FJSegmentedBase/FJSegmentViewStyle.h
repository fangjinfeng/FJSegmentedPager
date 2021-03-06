//
//  FJSegmentViewStyle.h
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/11/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 指示器 宽度 显示 类型
typedef NS_ENUM(NSInteger, FJSegmentIndicatorWidthShowType) {
    // 自适应
    FJSegmentIndicatorWidthShowTypeAdaption = 0,
    // 固定 宽度
    FJSegmentIndicatorWidthShowTypeAdaptionFixedWidth,
};


// 标题 view 字体颜色 改变 类型
typedef NS_ENUM(NSInteger, FJSegmentTitleViewTitleLabelChangeType) {
    // 选中 之后 再 颜色 改变
    FJSegmentTitleViewTitleLabelChangeTypeSelectedChange = 0,
    // 颜色 渐变
    FJSegmentTitleViewTitleLabelChangeTypeGradualChange,
};


@interface FJSegmentViewStyle : NSObject
// 选择 第几个 tag
@property (nonatomic, assign) NSInteger selectedIndex;
// 标题栏 宽度
@property (nonatomic, assign) CGFloat segmentedTitleViewWidth;
// 标题 栏 高度
@property (nonatomic, assign) CGFloat segmentedTitleViewHeight;
// 分割线 高度
@property (nonatomic, assign) CGFloat separatorLineHeight;
// 指示条 高度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewHeight;
// 指示条 宽度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewWidth;
// 指示条 距离 底部 间距
@property (nonatomic, assign) CGFloat segmentedIndicatorViewToBottomSpacing;
// 指示条 默认 扩展宽度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewExtendWidth;
// 标题 默认 宽度
@property (nonatomic, assign) CGFloat segmentedTitleViewTitleWidth;
// 标题栏 cell  间距
@property (nonatomic, assign) CGFloat segmentedTagSectionCellSpacing;
// 标题栏 左右 间距
@property (nonatomic, assign) CGFloat segmentedTagSectionHorizontalEdgeSpacing;
// 标题 字体
@property (nonatomic, strong) UIFont *itemTitleFont;
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
// tableView 背景色
@property (nonatomic, strong) UIColor *tableViewBackgroundColor;
// 指示器 背景色
@property (nonatomic, strong) UIColor *indicatorViewBackgroundColor;
// 禁止 宽度 平分
@property (nonatomic, assign) BOOL  forbidSectionViewDivideWidth;
// 指示器 宽度 显示 类型
@property (nonatomic, assign) FJSegmentIndicatorWidthShowType segmentIndicatorWidthShowType;
// 标题 字体 颜色 改变 类型
@property (nonatomic, assign) FJSegmentTitleViewTitleLabelChangeType titleLabelChangeType;
@end
