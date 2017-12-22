
//
//  FJPageCollectionViewCell.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJPageCollectionViewCell.h"


@implementation FJPageCollectionViewCell
// 依据controller 配置 cell
- (void)configCellWithViewController:(UIViewController *)ViewController {
    ViewController.view.frame = self.bounds;
    [self.contentView addSubview:ViewController.view];
}
@end
