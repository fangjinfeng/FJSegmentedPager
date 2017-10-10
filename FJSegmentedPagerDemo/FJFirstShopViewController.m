
//
//  FJFirstShopViewController.m
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/9/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJFirstShopViewController.h"

@interface FJFirstShopViewController ()

@end

@implementation FJFirstShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"店铺列表";
    
}

#pragma mark --- system delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/256.0 green:arc4random_uniform(256)/256.0 blue:arc4random_uniform(256)/256.0 alpha:1.0f];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}



@end
