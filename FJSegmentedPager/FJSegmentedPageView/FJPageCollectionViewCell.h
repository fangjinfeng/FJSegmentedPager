//
//  FJPageCollectionViewCell.h
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJPageCollectionViewCell : UICollectionViewCell
// 依据controller 配置 cell
- (void)configCellWithViewController:(UIViewController *)ViewController;
@end
