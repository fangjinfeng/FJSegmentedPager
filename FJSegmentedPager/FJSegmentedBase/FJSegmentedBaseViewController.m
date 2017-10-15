//
//  FJContainerBaseViewController.m
//  LemonLive
//
//  Created by fjf on 2017/6/14.
//  Copyright © 2017年 Qingning Science & Technology Development Co.,Ltd. All rights reserved.
//

#import "FJSegementContentView.h"
#import "FJSegmentedPageDefine.h"
#import "FJSegmentedBaseViewController.h"


static void * const kFJScrollViewKVOContext = (void*)&kFJScrollViewKVOContext;

@interface FJSegmentedBaseViewController ()

// 点击 返回 到 顶部view
@property (nonatomic, strong) UIView *scrollToTopTapView;
// current selected index
@property (nonatomic, assign) NSUInteger currentSelectedIndex;
// 能否 滚动
@property (nonatomic, assign, getter=isEnableScroll) BOOL enableScroll;

@end

@implementation FJSegmentedBaseViewController


#pragma mark --- life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContainerBaseControls];
    
    [self registerContainerBaseNotiInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self statusBar] addSubview:self.scrollToTopTapView];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scrollToTopTapView removeFromSuperview];
}

#pragma mark --- private method

- (void)setupContainerBaseControls {
    //适配ios7
    self.enableScroll = YES;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kFJControllerViewBackgroundColor;
}

// 注册 通知 监听
- (void)registerContainerBaseNotiInfo {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToSegmentedPage:) name:kFJScrollToSegmentedPageNoti object:nil];
}

#pragma mark --- system delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark --- scrollView delegate

// 子类 必须 调用 super
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 滑动 到 顶端
    if (offsetY >= self.tableViewOffsetY) {
        // 如果 不能 移动 就 固定
        if (self.enableScroll == NO) {
            scrollView.contentOffset = CGPointMake(0, self.tableViewOffsetY);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:[NSNumber numberWithBool:YES]];
        self.enableScroll = NO;
    }
    // 离开 顶端
    else {
        // 如果 不能 移动 就 固定
        if (self.enableScroll == NO) {
            scrollView.contentOffset = CGPointMake(0, self.tableViewOffsetY);
        }
    }
}

#pragma mark --- noti method

- (void)acceptMsg:(NSNotification *)noti {
    if ([noti.name isEqualToString:kLeaveTopNotificationName]) {
        NSNumber *tmpNum = noti.object;
        if (tmpNum.boolValue == YES) {
             self.enableScroll = YES;
        }
    }
}

- (void)scrollToSegmentedPage:(NSNotification *)noti {
    if ([noti.name isEqualToString:kFJScrollToSegmentedPageNoti]) {
        NSNumber *tmpNum = noti.object;
        self.currentSelectedIndex = tmpNum.unsignedIntegerValue;
    }
}

#pragma mark --- response event
// 滚动 到顶部
- (void)postScrollToTopViewNoti {
    NSString *tmpSelectedIndex = [NSString stringWithFormat:@"%ld", self.currentSelectedIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:kFJSubScrollViewScrollToTopNoti object:tmpSelectedIndex];
}

#pragma mark --- getter method
// 配置 模型 数组
- (NSMutableArray  <FJConfigModel *>*)configModelArray {
    if (!_configModelArray) {
        _configModelArray = [NSMutableArray array];
    }
    return _configModelArray;
}

// tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.backgroundColor = kFJTableViewBackgroundColor;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}


// 点击 返回 到 顶部view
- (UIView *)scrollToTopTapView {
    if (!_scrollToTopTapView) {
        _scrollToTopTapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30.0f)];
        _scrollToTopTapView.userInteractionEnabled = YES;
        [_scrollToTopTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postScrollToTopViewNoti)]];
        _scrollToTopTapView.backgroundColor = [UIColor clearColor];
    }
    return _scrollToTopTapView;
}

/**
 用KVC取statusBar
 
 @return statusBar
 */
- (UIView *)statusBar {
    
    return [[UIApplication sharedApplication] valueForKey:@"statusBar"];
}

#pragma mark --- dealloc method
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
