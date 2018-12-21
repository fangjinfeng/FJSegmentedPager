//
//  FJSecondShopViewController.h
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/9/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentPageChildVcDelegate.h"
#import "FJSegmentdPageViewController.h"

@interface FJSecondShopViewController : UIViewController<FJSegmentPageChildVcDelegate>
/**
 更新 tableView 高度
 
 @param tableViewHeight tableView高度
 */
- (void)updateTableViewHeight:(CGFloat)tableViewHeight;
@end
