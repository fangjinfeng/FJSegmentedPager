//
//  FJDoubleDeckRollCell.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/16.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJSegementContentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
// 滚动 view frame
@property (nonatomic, assign) CGRect rollViewFrame;
// 标题栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// 配置 数据 模型
@property (nonatomic, strong) NSArray *configModelArray;
// 选择 第几个 tag
@property (nonatomic, assign) NSInteger selectedIndex;
// baseViewControllerParam 参数
@property (nonatomic, strong) id baseViewControllerParam;
// 获取 view controller array
- (NSMutableArray *)getViewControllerArray;
// 改变 doubleDeckRollView 高度
- (void)changeDoubleDeckRollViewHeight:(CGFloat)height;
@end
