//
//  FJSegementContentView
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJConfigModel;

@interface FJSegementContentView : UIView
// 默认 选中 索引(先传入:configModelArray,再设置:selectedIndex)
@property (nonatomic, assign) NSInteger selectedIndex;
// 标题 栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// baseViewControllerParam 参数
@property (nonatomic, strong) id baseViewControllerParam;
// 配置 数据 模型
@property (nonatomic, strong) NSArray <FJConfigModel *>*configModelArray;

// 获取 view controller array
- (NSMutableArray *)getViewControllerArray;
@end
