

//
//  FJSegementContentCell.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/16.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentViewStyle.h"
#import "FJSegementContentView.h"
#import "FJSegementContentCell.h"

@interface FJSegementContentCell()
// 滚动 栏
@property (nonatomic, strong) FJSegementContentView *doubleDeckRollView;

@end

@implementation FJSegementContentCell

#pragma mark --- init method
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"FJSegementContentCellId";
    FJSegementContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[FJSegementContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupControls];
    }
    return self;
}
#pragma mark --- public method
// 获取 view controller array
- (NSMutableArray *)getViewControllerArray {
    return [self.doubleDeckRollView getViewControllerArray];
}
#pragma mark --- private method
// 设置 
- (void)setupControls {
    [self.contentView addSubview:self.doubleDeckRollView];
}

#pragma mark --- setter method
// 设置 模型 数据
- (void)setConfigModelArray:(NSArray *)configModelArray {
    self.doubleDeckRollView.configModelArray = configModelArray;
}

// 设置 滚动栏 frame
- (void)setRollViewFrame:(CGRect)rollViewFrame {
    self.doubleDeckRollView.frame = rollViewFrame;
}

// 设置 tagSectionView 高度
- (void)setTagSectionViewHeight:(CGFloat)tagSectionViewHeight {
    self.doubleDeckRollView.tagSectionViewHeight = tagSectionViewHeight;
}
// 设置 viewController 参数
- (void)setBaseViewControllerParam:(id)baseViewControllerParam {
    self.doubleDeckRollView.baseViewControllerParam = baseViewControllerParam;
}

// 选择 第几个 tag
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    self.doubleDeckRollView.selectedIndex = selectedIndex;
}

// 改变 doubleDeckRollView 高度
- (void)changeDoubleDeckRollViewHeight:(CGFloat)height {
    CGRect doubleDeckRollViewFrame = self.doubleDeckRollView.frame;
    doubleDeckRollViewFrame.size.height = height;
    self.doubleDeckRollView.frame = doubleDeckRollViewFrame;
}

// 配置 属性
- (void)setSegmentViewStyle:(FJSegmentViewStyle *)segmentViewStyle {
    _segmentViewStyle = segmentViewStyle;
    if (_segmentViewStyle) {
        _doubleDeckRollView.segmentViewStyle = _segmentViewStyle;
    }
}

#pragma mark --- getter method
// 滚动 栏
- (FJSegementContentView *)doubleDeckRollView {
    if (!_doubleDeckRollView) {
        _doubleDeckRollView = [[FJSegementContentView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _doubleDeckRollView;
}
@end
