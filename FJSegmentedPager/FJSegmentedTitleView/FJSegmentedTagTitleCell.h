//
//  FJTagCollectionViewCell.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJSegmentViewStyle;

@interface FJSegmentedTagTitleCell : UIView
// 标题 内容
@property (nonatomic, copy)   NSString *titleStr;
@property (strong, nonatomic) UIColor *textColor;
// 属性 配置
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;
// 设置 选中
- (void)setSelectedStatus:(BOOL)selectedStatus;
@end
