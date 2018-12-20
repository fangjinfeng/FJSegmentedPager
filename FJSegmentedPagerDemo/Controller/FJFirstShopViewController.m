
//
//  FJFirstShopViewController.m
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/9/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "UIView+FJFrame.h"
#import "FJFirstShopViewController.h"

@interface FJFirstShopViewController ()

@end

@implementation FJFirstShopViewController

#pragma mark --------------- Public Methods
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

#pragma mark --------------- Private Methods

- (void)setupViewControls {
    self.tableView.fj_height += 20.0f;
}

@end
