//
//  FJTagCollectionViewCell.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJSegmentViewStyle;
// cell id
UIKIT_EXTERN NSString * const kFJTagCollectionViewCellId;

@interface FJSegmentedTagTitleCell : UICollectionViewCell
// 标题 内容
@property (nonatomic, copy)   NSString *titleStr;
// 属性 配置
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;
// 设置 选中
- (void)setSelectedStatus:(BOOL)selectedStatus;
@end
