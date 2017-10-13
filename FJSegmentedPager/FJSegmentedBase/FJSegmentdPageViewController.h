//
//  FJDetailContentBaseViewController.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJBaseTableView.h"

@interface FJSegmentdPageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

// 当前 索引
@property (nonatomic, assign) NSInteger   currentIndex;
// 通知 相关
@property (nonatomic, strong) NSDictionary *notiInfo;
// tableView
@property (nonatomic, strong) FJBaseTableView *tableView;
// 标题 栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// 参数 baseViewControllerParam
@property (nonatomic, copy) id baseViewControllerParam;
// 参数
@property (nonatomic, copy) id pageViewControllerParam;
// 是否 可滚动
@property (nonatomic, assign, getter=isEnableScroll) BOOL enableScroll;

@end
