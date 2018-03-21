//
//  FJShopSegmentedViewController.m
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/11/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJConfigModel.h"
#import "FJSegmentViewStyle.h"
#import "FJSegementContentView.h"
#import "FJShopSegmentedViewController.h"

@interface FJShopSegmentedViewController ()
// 滚动 栏
@property (nonatomic, strong) FJSegementContentView *doubleDeckRollView;
@end

@implementation FJShopSegmentedViewController

#pragma mark --- life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupControls];
}



#pragma mark --- private method

// 设置 子控件
- (void)setupControls {
    
    self.navigationItem.title = @"店铺详情";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.doubleDeckRollView];
    self.view.backgroundColor = [UIColor whiteColor];
}

// 配置 课程 列表  数组
- (NSMutableArray *)configViewControllerModelArray {
    NSMutableArray *configModelArray = [NSMutableArray array];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"店铺简介" viewControllerStr:@"FJFirstShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"店铺课程" viewControllerStr:@"FJSecondShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"店铺商品" viewControllerStr:@"FJFirstShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"店铺推荐" viewControllerStr:@"FJSecondShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"店铺专栏" viewControllerStr:@"FJFirstShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"VIP" viewControllerStr:@"FJSecondShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"大礼包" viewControllerStr:@"FJFirstShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"店铺特色" viewControllerStr:@"FJSecondShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"免费" viewControllerStr:@"FJFirstShopViewController"]];
    [configModelArray addObject:[[FJConfigModel alloc] initWithTitleStr:@"店铺主打" viewControllerStr:@"FJSecondShopViewController"]];
    return configModelArray;
}

#pragma mark --- getter method
// 滚动 栏
- (FJSegementContentView *)doubleDeckRollView {
    if (!_doubleDeckRollView) {
        _doubleDeckRollView = [[FJSegementContentView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height)];
        FJSegmentViewStyle *tmpSegmentViewStyle = [[FJSegmentViewStyle alloc] init];
        tmpSegmentViewStyle.eliminateSubViewScrollLimit = YES;
        _doubleDeckRollView.segmentViewStyle = tmpSegmentViewStyle;
        _doubleDeckRollView.configModelArray = [self configViewControllerModelArray];
    }
    return _doubleDeckRollView;
}

@end