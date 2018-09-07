//
//  FJSegmentViewStyle.m
//  FJSegmentedPagerDemo
//
//  Created by fjf on 2017/11/29.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentViewStyle.h"
#import "FJSegmentedPageDefine.h"

@implementation FJSegmentViewStyle

#pragma mark --------------- Init Methods

- (instancetype)init {
    if (self = [super init]) {
        _selectedIndex = 0;
        _itemTitleFont = kFJSegmentedTitleFontSize;
        _itemTitleSelectedFont = kFJSegmentedTitleFontSize;
        _tagSectionViewHeight = kFJSegmentedTitleViewHeight;
        _segmentToolbackgroundColor = kFJSegmentToolbackgroundColor;
        _itemTitleColorStateNormal = kFJSegmentedTitleNormalColor;
        _itemTitleColorStateSelected = kFJSegmentedTitleSelectedColor;
        _itemTitleColorStateHighlighted = kFJSegmentedTitleHighlightColor;
        _separatorBackgroundColor = kFJBottomLineViewBackgroundColor;
        _indicatorViewBackgroundColor = kFJSegmentedIndicatorViewColor;
        _tableViewBackgroundColor = kFJTableViewBackgroundColor;
        _separatorLineHeight = kFJSegmentedBottomLineViewHeight;
        _segmentedIndicatorViewHeight = kFJSegmentedIndicatorViewHeight;
        _segmentedIndicatorViewWidth = kFJSegmentedIndicatorViewWidth;
        _segmentedIndicatorViewExtendWidth = kFJSegmentedIndicatorViewExtendWidth;
        _segmentedTitleViewTitleWidth = kFJSegmentedTitleViewTitleWidth;
        _segmentedTagSectionCellSpacing = kFJSegmentedTagSectionCellSpacing;
        _segmentedTagSectionHorizontalEdgeSpacing = kFJSegmentedTagSectionHorizontalEdgeSpacing;
        _segmentedIndicatorViewToBottomSpacing = 0.0f;
        _segmentIndicatorWidthShowType = FJSegmentIndicatorWidthShowTypeAdaption;
        _titleColorChangeType = FJSegmentTitleViewTitleColorChangeTypeSelectedChange;
    }
    return self;
}
@end
