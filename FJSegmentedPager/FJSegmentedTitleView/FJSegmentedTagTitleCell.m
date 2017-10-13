
//
//  FJTagCollectionViewCell.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJDoubleDeckRollDefine.h"
#import "FJSegmentedTagTitleCell.h"

// id 标识符
NSString * const kFJTagCollectionViewCellId = @"kFJTagCollectionViewCellId";

@interface FJSegmentedTagTitleCell()
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation FJSegmentedTagTitleCell

#pragma mark --- init method
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark --- private method
// 设置 默认 值
- (void)setDefaultValues {
    self.titleFont = kFJSegmentedTitleFontSize;
    self.titleNormalColor = kFJSegmentedTitleNormalColor;
    self.titleSelectedColor = kFJSegmentedTitleSelectedColor;
    self.titleHighlightColor = kFJSegmentedTitleHighlightColor;
}

#pragma mark --- Override method
// 设置 选中 
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.titleLabel.textColor = self.titleSelectedColor;
    }
    else{
        self.titleLabel.textColor = self.titleNormalColor;
    }
}

#pragma mark --- layout method

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    CGPoint titleLabelCenter = self.titleLabel.center;
    titleLabelCenter.y = self.center.y - 5;
    self.titleLabel.center = titleLabelCenter;
}

#pragma mark --- getter method

// title Label
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = self.titleFont;
        _titleLabel.textColor = self.titleNormalColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


#pragma mark --- setter method

// 标题 内容
- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

// 标题 字体
- (void)setTitleFont:(UIFont *)titleFont {
    
    self.titleLabel.font = titleFont;
}

// 标题 普通 颜色
- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    _titleLabel.textColor = _titleNormalColor;
}
// 标题 选中 颜色
- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleSelectedColor = titleSelectedColor;
}

// 标题 高亮 颜色
- (void)setTitleHighlightColor:(UIColor *)titleHighlightColor {
    _titleHighlightColor = titleHighlightColor;
}

@end
