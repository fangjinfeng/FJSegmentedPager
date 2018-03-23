

//
//  FJConfigModel.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJConfigModel.h"

@implementation FJConfigModel

#pragma mark --------------- Life Circle
- (instancetype)initWithTitleStr:(NSString *)titleStr
               viewControllerStr:(NSString *)viewControllerStr {
    return [self initWithTitleStr:titleStr viewControllerStr:viewControllerStr pageViewControllerParam:nil];
}


- (instancetype)initWithTitleStr:(NSString *)titleStr
               viewControllerStr:(NSString *)viewControllerStr
         pageViewControllerParam:(id)pageViewControllerParam {
    if (self = [super init]) {
        _titleStr = [titleStr copy];
        _viewControllerStr = [viewControllerStr copy];
        _pageViewControllerParam = pageViewControllerParam;
    }
    return self;
}
@end
