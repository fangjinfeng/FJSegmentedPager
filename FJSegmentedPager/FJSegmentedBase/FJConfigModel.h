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

// 依据 参数 初始化
- (instancetype)initWithTitleStr:(NSString *)titleStr
               viewControllerStr:(NSString *)viewControllerStr;


// 依据 参数 初始化
- (instancetype)initWithTitleStr:(NSString *)titleStr
               viewControllerStr:(NSString *)viewControllerStr
         pageViewControllerParam:(id)pageViewControllerParam;
@end
