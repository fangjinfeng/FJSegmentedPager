//
//  FJShopViewController.m
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/11/7.
//  Copyright © 2017年 fjf. All rights reserved.
//

// tool
#import "FJSegmentViewStyle.h"
// view
#import "QNPersonalHeaderView.h"
// vc
#import "FJFirstShopViewController.h"
#import "FJFirstShopSegmentedViewController.h"

@interface FJFirstShopSegmentedViewController ()<FJSegmentPageViewDelegate,FJSegmentPageViewDataSource>
// 标题
@property (nonatomic, strong) NSArray <NSString *> *titleArray;

// segmentViewStyle
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;
@end

@implementation FJFirstShopSegmentedViewController

#pragma mark --------------- Life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupControls];
}

#pragma mark --------------- System Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FJSegementContentCell *segementContentCell = [FJSegementContentCell cellWithTableView:tableView];
    segementContentCell.segmentViewStyle = self.segmentViewStyle;
    segementContentCell.segementPageView.dataSource = self;
    segementContentCell.segementPageView.delegate = self;
    return segementContentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIScreen mainScreen].bounds.size.height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark --------------- Custom Delegate

#pragma mark ----  FJSegmentPageViewDataSource
// 子页面 总数
- (NSInteger)numberOfChildViewControllers {
    return self.titleArray.count;
}

// 子页面 标题
- (NSArray<NSString *> *)titlesArrayOfChildViewControllers {
    return self.titleArray;
}

/** 获取到将要显示的页面的控制器
 * reuseViewController : 这个是返回给你的controller, 你应该首先判断这个是否为nil, 如果为nil 创建对应的控制器并返回, 如果不为nil直接使用并返回
 * index : 对应的下标
 */
- (UIViewController<FJSegmentPageChildVcDelegate> *)childViewController:(UIViewController<FJSegmentPageChildVcDelegate> *)reuseViewController withIndex:(NSInteger)index {
    UIViewController<FJSegmentPageChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[FJFirstShopViewController alloc] init];
    }
    return childVc;
}

#pragma mark ----  FJSegmentPageViewDelegate
// 子页面 即将 显示
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController withIndex:(NSInteger)index {
    
}

// 子页面 已经 显示
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController withIndex:(NSInteger)index {
    
}

// 子页面 即将 消失
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController withIndex:(NSInteger)index {
    
}

// 子页面 已经 消失
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController withIndex:(NSInteger)index {
    
}


#pragma mark --------------- Private Methods

// 设置 子控件
- (void)setupControls {
    
    self.navigationItem.title = @"店铺详情";
    
    self.tableView.tableHeaderView = [QNPersonalHeaderView createView];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableViewOffsetY = [self.tableView rectForSection:0].origin.y + 10;
    });
}


#pragma mark --------------- Getter / Setter

- (FJSegmentViewStyle *)segmentViewStyle {
    if (!_segmentViewStyle) {
        _segmentViewStyle = [[FJSegmentViewStyle alloc] init];
        _segmentViewStyle.itemTitleFont = [UIFont systemFontOfSize:14.0f];
        _segmentViewStyle.itemTitleSelectedFont = [UIFont boldSystemFontOfSize:16.0f];
        _segmentViewStyle.segmentedIndicatorViewWidth = 16.0f;
        _segmentViewStyle.segmentedIndicatorViewWidthToBottomSpacing = 10.0f;
        _segmentViewStyle.segmentIndicatorWidthShowType = FJSegmentIndicatorWidthShowTypeAdaptionFixedWidth;
        _segmentViewStyle.titleColorChangeType = FJSegmentTitleViewTitleColorChangeTypeGradualChange;
    }
    return _segmentViewStyle;
}


- (NSArray <NSString *> *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"店铺简介",
                       @"店铺课程",
                       @"VIP",
                       @"大礼包",
                       nil
                       ];
    }
    return _titleArray;
}

@end
