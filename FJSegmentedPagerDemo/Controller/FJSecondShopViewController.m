
//
//  FJSecondShopViewController.m
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/9/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "UIView+FJFrame.h"
#import "FJSegmentedPageDefine.h"
#import "FJSecondShopViewController.h"

@interface FJSecondShopViewController ()<UITableViewDataSource,UITableViewDelegate>
// tableView
@property (nonatomic, strong) UITableView *tableView;
// tableViewHeight
@property (nonatomic, assign) CGFloat  tableViewHeight;
@end

@implementation FJSecondShopViewController

#pragma mark --------------- Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControls];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


#pragma mark --------------- Public Methods
- (void)updateTableViewHeight:(CGFloat)tableViewHeight {
    _tableViewHeight = tableViewHeight;
}
#pragma mark --------------- Private Methods
// 设置 控件
- (void)setupViewControls {
     self.edgesForExtendedLayout = UIRectEdgeNone;
    if (_tableViewHeight == 0) {
        _tableViewHeight = self.view.fj_height;
    }
    [self.view addSubview:self.tableView];
}

#pragma mark --------------- System Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/256.0 green:arc4random_uniform(256)/256.0 blue:arc4random_uniform(256)/256.0 alpha:1.0f];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.0f;
}

#pragma mark --------------- Getter / Setter
// tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _tableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
