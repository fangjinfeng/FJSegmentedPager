//
//  FJShopSegmentedViewController.m
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/11/29.
//  Copyright © 2017年 fjf. All rights reserved.
//


#import "FJSegmentViewStyle.h"
#import "FJSegementPageView.h"
#import "FJSecondShopViewController.h"
#import "FJFirstShopViewController.h"
#import "FJThreeShopSegmentedViewController.h"

@interface FJThreeShopSegmentedViewController ()<FJSegmentPageViewDataSource>
// 标题
@property (nonatomic, strong) NSArray <NSString *> *titleArray;
// 滚动 栏
@property (nonatomic, strong) FJSegementPageView *segementPageView;

// segmentViewStyle
@property (nonatomic, strong) FJSegmentViewStyle *segmentViewStyle;
@end

@implementation FJThreeShopSegmentedViewController

#pragma mark --------------- Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupControls];
}

#pragma mark --------------- Custom Delegate
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
        childVc = [[FJSecondShopViewController alloc] init];
    }
    return childVc;
}


#pragma mark --------------- Private Methods

// 设置 子控件
- (void)setupControls {
    
    self.navigationItem.title = @"店铺详情";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.segementPageView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark --------------- Getter / Setter

- (NSArray <NSString *> *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"店铺简介",
                       @"店铺课程",
                       @"店铺商品",
                       @"店铺专栏",
                       @"VIP",
                       @"大礼包",
                       @"店铺特色",
                       @"免费",
                       @"店铺主打",
                       nil
                       ];
    }
    return _titleArray;
}
// 滚动 栏
- (FJSegementPageView *)segementPageView {
    if (!_segementPageView) {
        _segementPageView = [[FJSegementPageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height)];
        _segementPageView.segmentViewStyle = self.segmentViewStyle;
        _segementPageView.dataSource = self;
    }
    return _segementPageView;
}


- (FJSegmentViewStyle *)segmentViewStyle {
    if (!_segmentViewStyle) {
        _segmentViewStyle = [[FJSegmentViewStyle alloc] init];
        _segmentViewStyle.itemTitleFont = [UIFont systemFontOfSize:14.0f];
        _segmentViewStyle.itemTitleSelectedFont = [UIFont boldSystemFontOfSize:14.0f];
        _segmentViewStyle.segmentedIndicatorViewWidth = 16.0f;
        _segmentViewStyle.segmentedIndicatorViewWidthToBottomSpacing = 10.0f;
        _segmentViewStyle.segmentIndicatorWidthShowType = FJSegmentIndicatorWidthShowTypeAdaptionFixedWidth;
        _segmentViewStyle.titleColorChangeType = FJSegmentTitleViewTitleColorChangeTypeGradualChange;
    }
    return _segmentViewStyle;
}

@end
