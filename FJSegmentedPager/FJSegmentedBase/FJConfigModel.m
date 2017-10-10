

//
//  FJConfigModel.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJConfigModel.h"

@implementation FJConfigModel
#pragma  mark --- init method

//  返回 依据 titleStr 和 viewControllerStr 配置的模型
- (instancetype)initWithTitleStr:(NSString *)titleStr
               viewControllerStr:(NSString *)viewControllerStr {
    if (self = [super init]) {
        _titleStr = [titleStr copy];
        _viewControllerStr = [viewControllerStr copy];
    }
    return self;
}
@end
