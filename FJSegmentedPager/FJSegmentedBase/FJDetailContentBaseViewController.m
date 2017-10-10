//
//  FJDetailContentBaseViewController.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJDoubleDeckRollDefine.h"
#import "FJDetailContentBaseViewController.h"
#import "UIViewController+FJCurrentViewController.h"


@interface FJDetailContentBaseViewController ()
@end

@implementation FJDetailContentBaseViewController

#pragma mark --- life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDetailContentViewControls];
    
    [self registerDetailContentViewNotiInfo];
}


#pragma mark --- private method
// 设置 子控件
- (void)setupDetailContentViewControls {
    //适配ios7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
}

// 注册 监听
- (void)registerDetailContentViewNotiInfo {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kGoTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];//其中一个TAB离开顶部的时候，如果其他几个偏移量不为0的时候，要把他们都置为0
    
}

#pragma mark --- system delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}


/************************ UIScrollViewDelegate **********************/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.isEnableScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotificationName object:[NSNumber numberWithBool:YES] userInfo:nil];
    }
}

#pragma mark --- noti method
- (void)acceptMsg:(NSNotification *)notification {
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kGoTopNotificationName]) {
        NSNumber *tmpNum = (NSNumber *)notification.object;
        if (tmpNum.boolValue == YES) {
            self.enableScroll = tmpNum.boolValue;
            self.tableView.showsVerticalScrollIndicator = YES;
        }
    }else if([notificationName isEqualToString:kLeaveTopNotificationName]){
        self.tableView.contentOffset = CGPointZero;
        self.enableScroll = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
    }
}


#pragma mark --- setter method

// 设置 tagSectionViewHeight
- (void)setTagSectionViewHeight:(CGFloat)tagSectionViewHeight {
    _tagSectionViewHeight = tagSectionViewHeight;
}


#pragma mark --- getter method
// tableView
- (FJBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[FJBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kFJTableViewBackgroundColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self tableFooterViewHeight])];
    }
    return _tableView;
}

// tableFooter view height
- (CGFloat)tableFooterViewHeight {
    CGFloat footerViewHeight = _tagSectionViewHeight;
    if ([UIViewController fj_currentViewController].navigationController && [UIViewController fj_currentViewController].navigationController.navigationBar.isHidden == NO) {
        footerViewHeight += 64.0f;
    }
    if ([UIViewController fj_currentViewController].tabBarController && [UIViewController fj_currentViewController].tabBarController.tabBar.isHidden == NO) {
        footerViewHeight += 49.0f;
    }
    return footerViewHeight;
}

#pragma mark --- dealloc method
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
