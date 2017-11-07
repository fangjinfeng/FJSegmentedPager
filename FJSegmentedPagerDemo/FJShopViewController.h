//
//  FJShopViewController.h
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/11/7.
//  Copyright © 2017年 fjf. All rights reserved.
//


#import "FJSegmentedBaseViewController.h"

@interface FJShopViewController : FJSegmentedBaseViewController
// 是否 超过 一屏
@property (nonatomic, getter=isBeyondScreenWidth, assign) BOOL beyondScreenWidth;
@end
