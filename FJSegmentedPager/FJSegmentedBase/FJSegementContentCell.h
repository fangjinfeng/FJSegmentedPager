//
//  FJDoubleDeckRollCell.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/16.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSegementPageView.h"
@class FJSegmentViewStyle;

@interface FJSegementContentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
// 滚动 栏
@property (nonatomic, strong) FJSegementPageView *segementPageView;
// 滚动 view frame
@property (nonatomic, assign) CGRect rollViewFrame;
// 属性 配置
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;

@end
