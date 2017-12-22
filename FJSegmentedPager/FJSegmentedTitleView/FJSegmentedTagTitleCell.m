
//
//  FJTagCollectionViewCell.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentViewStyle.h"
#import "FJSegmentedPageDefine.h"
#import "FJSegmentedTagTitleCell.h"


@interface FJSegmentedTagTitleCell()
// 标题 正常 字体
@property (nonatomic, strong) UIFont *titleNormalFont;
// 标题 选中 字体
@property (nonatomic, strong) UIFont *titleSelectedFont;
// 标题 正常 颜色
@property (nonatomic, strong) UIColor *titleNormalColor;
// 标题 选中 颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
// 标题 高亮 颜色
@property (nonatomic, strong) UIColor *titleHighlightColor;
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
    self.titleNormalFont = kFJSegmentedTitleFontSize;
    self.titleSelectedFont = kFJSegmentedTitleFontSize;
    self.titleNormalColor = kFJSegmentedTitleNormalColor;
    self.titleSelectedColor = kFJSegmentedTitleSelectedColor;
    self.titleHighlightColor = kFJSegmentedTitleHighlightColor;
}

#pragma mark --- Override method

// 设置 选中
- (void)setSelectedStatus:(BOOL)selectedStatus {
    if (selectedStatus) {
        self.titleLabel.textColor = self.titleSelectedColor;
        self.titleLabel.font = self.titleSelectedFont;
    }
    else{
        self.titleLabel.textColor = self.titleNormalColor;
        self.titleLabel.font = self.titleNormalFont;
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




#pragma mark --- setter method

// 标题 内容
- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}


// 配置 属性
- (void)setSegmentViewStyle:(FJSegmentViewStyle *)segmentViewStyle {
    _segmentViewStyle = segmentViewStyle;
    if (_segmentViewStyle) {
        self.titleNormalFont = _segmentViewStyle.itemTitleFont;
        self.titleSelectedFont = _segmentViewStyle.itemTitleSelectedFont;
        self.titleNormalColor = _segmentViewStyle.itemTitleColorStateNormal;
        self.titleSelectedColor = _segmentViewStyle.itemTitleColorStateSelected;
        self.titleHighlightColor = _segmentViewStyle.itemTitleColorStateHighlighted;
    }
}

#pragma mark --- getter method

// title Label
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = self.titleNormalFont;
        _titleLabel.textColor = self.titleNormalColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
