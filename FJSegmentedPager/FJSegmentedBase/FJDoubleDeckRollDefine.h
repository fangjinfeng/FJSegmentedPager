//
//  FJDoubleDeckRollDefine.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#ifndef FJDoubleDeckRollDefine_h
#define FJDoubleDeckRollDefine_h

#import "FJConfigModel.h"
#import "FJBaseTableView.h"
#import "FJSegementContentView.h"

//进入置顶命令
static NSString *const kGoTopNotificationName = @"goTop";
//离开置顶命令
static NSString *const kLeaveTopNotificationName = @"leaveTop";


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
// 标题 默认 宽度
#define kFJSegmentedTitleViewTitleWidth     80.0f

static const CGFloat kFJIndicatorViewHeight = 2.0f;
static const CGFloat kFJIndicatorViewWidth = 56.0f;
static const CGFloat kFJTitleTagSectionTitleWidth = 80.0f;


#endif /* FJDoubleDeckRollDefine_h */




