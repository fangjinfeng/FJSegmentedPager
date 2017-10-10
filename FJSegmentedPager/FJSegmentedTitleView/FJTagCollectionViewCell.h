//
//  FJTagCollectionViewCell.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

// cell id
UIKIT_EXTERN NSString * const kFJTagCollectionViewCellId;

@interface FJTagCollectionViewCell : UICollectionViewCell
// 标题 内容
@property (nonatomic, copy)   NSString *titleStr;
// 标题 正常 字体
@property (nonatomic, strong) UIFont *titleFont;
// 标题 正常 颜色
@property (nonatomic, strong) UIColor *titleNormalColor;
// 标题 选中 颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
// 标题 高亮 颜色
@property (nonatomic, strong) UIColor *titleHighlightColor;

@end
