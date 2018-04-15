//
//  FJContainerBaseViewController.h
//  LemonLive
//
//  Created by fjf on 2017/6/14.
//  Copyright © 2017年 Qingning Science & Technology Development Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSegementContentCell.h"

@interface FJSegmentedBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
// tableView 偏移 位置
@property (nonatomic, assign) CGFloat tableViewOffsetY;
// tableView
@property (nonatomic, strong) UITableView *tableView;
@end
