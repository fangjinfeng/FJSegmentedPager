//
//  FJSegmentedPageDefine.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#ifndef FJSegmentedPageDefine_h
#define FJSegmentedPageDefine_h

#import "FJConfigModel.h"
#import "FJBaseTableView.h"
#import "FJSegementContentView.h"

// go top tip
static NSString *const kGoTopNotificationName = @"kGoTopNotificationName";
// leave top noti
static NSString *const kLeaveTopNotificationName = @"kLeaveTopNotificationName";

// current scroll to segmented page noti
static NSString *const kFJScrollToSegmentedPageNoti = @"kFJScrollToSegmentedPageNoti";
// scroll to top noti
static NSString *const kFJSubScrollViewScrollToTopNoti = @"kFJSubScrollViewScrollToTopNoti";




// 颜色

//(这个以后去掉)
#define FJColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//使用这个配置
#define FJColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// 分段 标题 字体 普通 颜色
#define kFJSegmentedTitleNormalColor FJColorFromRGB(0xA7A7A7)

// 分段 标题 字体 选中 颜色
#define kFJSegmentedTitleSelectedColor FJColorFromRGB(0x51D6AA)

// 分段 标题 字体 高亮 颜色
#define kFJSegmentedTitleHighlightColor FJColorFromRGB(0x51D6AA)

// 分段 标题 字体 高亮 颜色
#define kFJSegmentedIndicatorViewColor FJColorFromRGB(0x51D6AA)

// 分割线 背景 颜色
#define kFJBottomLineViewBackgroundColor FJColorFromRGB(0xEEEEF2)

// tableView 背景 颜色
#define kFJTableViewBackgroundColor FJColorFromRGB(0xF7F7FA)

// controllerView 背景 颜色
#define kFJControllerViewBackgroundColor FJColorFromRGB(0xF7F7FA)

/** 字体 **/

// font
#define kFJSystemFontSize(a) [UIFont systemFontOfSize:a]

// 分段 标题 字体 大小
#define kFJSegmentedTitleFontSize kFJSystemFontSize(14)

/** 高度 **/

// 分割线 默认 高度
#define kFJSegmentedBottomLineViewHeight    0.5
// 指示条 默认 高度
#define kFJSegmentedIndicatorViewHeight     2.0
// 指示条 默认 宽度
#define kFJSegmentedIndicatorViewWidth      56.0f
// 指示条 默认 扩展宽度
#define kFJSegmentedIndicatorViewExtendWidth  6.0f
// 标题 默认 宽度
#define kFJSegmentedTitleViewTitleWidth     80.0f
// 标题栏 cell  间距
#define kFJSegmentedTagSectionCellSpacing   32.0f
// 标题栏 cell  间距
#define kFJSegmentedTagSectionHorizontalEdgeSpacing 12.0f

#endif /* FJSegmentedPageDefine_h */




