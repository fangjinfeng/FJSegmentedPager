//
//  ViewController.m
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/9/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "ViewController.h"
#import "FJFirstShopSegmentedViewController.h"
#import "FJSecondShopSegmentedViewController.h"
#import "FJThreeShopSegmentedViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
// tableView
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

#pragma mark --- life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupControls];
}


#pragma mark --- private method

- (void)setupControls {
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"分类栏";
}

#pragma mark --- system delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"一屏内";
    }
    else if(indexPath.row == 1){
        cell.textLabel.text = @"超过一屏";
    }
    else {
        cell.textLabel.text = @"去掉头部";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        FJFirstShopSegmentedViewController *shopViewController = [[FJFirstShopSegmentedViewController alloc] init];
        shopViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shopViewController animated:YES];
    }
    else if(indexPath.row == 1){
        FJSecondShopSegmentedViewController *segmentViewController = [[FJSecondShopSegmentedViewController alloc] init];
        segmentViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:segmentViewController animated:YES];
    }
    else {
        FJThreeShopSegmentedViewController *segmentViewController = [[FJThreeShopSegmentedViewController alloc] init];
        segmentViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:segmentViewController animated:YES];
    }
    
}

#pragma mark --- getter method
// tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
    }
    return _tableView;
}
@end
