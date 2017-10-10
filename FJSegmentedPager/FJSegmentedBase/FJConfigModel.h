//
//  FJConfigModel.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJConfigModel : NSObject
// 标题 str
@property (nonatomic, copy) NSString *titleStr;
// 视图 str
@property (nonatomic, copy) NSString *viewControllerStr;
// 参数
@property (nonatomic, copy) id pageViewControllerParam;
/**
 返回 依据 titleStr 和 viewControllerStr 配置的模型

 @param titleStr 标题
 @param viewControllerStr viewControllerStr
 @return 配置 模型
 */
- (instancetype)initWithTitleStr:(NSString *)titleStr
               viewControllerStr:(NSString *)viewControllerStr;
@end
