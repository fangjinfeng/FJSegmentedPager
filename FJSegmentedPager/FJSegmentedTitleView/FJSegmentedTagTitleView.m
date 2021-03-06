//
//  FJTitleTagSectionView.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentViewStyle.h"
#import "FJSegmentedTagTitleView.h"
#import "FJSegmentedPageDefine.h"
// UIView
#import "FJSegmentedTagTitleCell.h"


@interface FJSegmentedTagTitleView() <UIScrollViewDelegate>
// 用于懒加载计算文字的rgba差值, 用于颜色渐变的时候设置
@property (strong, nonatomic) NSArray *deltaRGBA;
@property (strong, nonatomic) NSArray *selectedColorRGBA;
@property (strong, nonatomic) NSArray *normalColorRGBA;


// 标题 数据 数组
@property (nonatomic, strong) NSArray *tagTitleArray;
// 指示器 indicator
@property (nonatomic, strong) UIView *indicatorView;
// 分割 view
@property (nonatomic, strong) UIView *bottomLineView;
// 先前 索引
@property (nonatomic, assign) NSUInteger previousIndex;;
// 先前 进度
@property (nonatomic, assign) CGFloat  previousProgress;
// 是否 超过 宽度 限制
@property (nonatomic, assign) BOOL isBeyondLimitWidth;
// 标题 栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// 标题栏 titleScrollView
@property (nonatomic, strong) UIScrollView *titleScrollView;
// 标题 cell 数组
@property (nonatomic, strong) NSMutableArray <NSNumber *>*titleWidthMarray;
// 标题 cell frame 数组
@property (nonatomic, strong) NSMutableArray <NSString *>*titleCellFrameMarray;
// 标题 cell 数组
@property (nonatomic, strong) NSMutableArray <FJSegmentedTagTitleCell *>*titleCellMarray;
@end

@implementation FJSegmentedTagTitleView

#pragma mark --------------- Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupControls];
    }
    return self;
}



#pragma mark --------------- Public Methods

- (void)reloadData {
    if (self.segmentPageDataSource && [self.segmentPageDataSource respondsToSelector:@selector(titlesArrayOfChildViewControllers)]) {
        self.tagTitleArray = [self.segmentPageDataSource titlesArrayOfChildViewControllers];
    }
    else {
        NSAssert(NO, @"必须实现的代理方法:titlesArrayOfChildViewControllers");
    }
}

// 设置 选中 索引
- (void)setupSelectedIndex:(NSInteger )selectedIndex animated:(BOOL)animated {
    self.selectedIndex = selectedIndex;
    [self updateControlsStatusWithCurrentIndex:selectedIndex animated:animated];
}

// 依据 参数 更新 控件
- (void)updateControlsWithPreviousIndex:(NSInteger)previousIndex currentIndex:(NSInteger)currentIndex progress:(CGFloat)progress {
    if (previousIndex < 0 ||
        previousIndex >= self.tagTitleArray.count ||
        currentIndex < 0 ||
        currentIndex >= self.tagTitleArray.count
        ) {
        return;
    }
    
    FJSegmentedTagTitleCell *oldTitleView = (FJSegmentedTagTitleCell *)self.titleCellMarray[previousIndex];
    FJSegmentedTagTitleCell *currentTitleView = (FJSegmentedTagTitleCell *)self.titleCellMarray[currentIndex];


    CGFloat xDistance = currentTitleView.fj_x - oldTitleView.fj_x;
    CGFloat wDistance = currentTitleView.fj_width - oldTitleView.fj_width;

    // 宽度 自适应
    if (_segmentViewStyle.segmentIndicatorWidthShowType == FJSegmentIndicatorWidthShowTypeAdaption) {
        if (self.isBeyondLimitWidth) {
            self.indicatorView.fj_x = oldTitleView.fj_x + xDistance * progress;
            self.indicatorView.fj_width = oldTitleView.fj_width + wDistance * progress;
        }
        else {
            CGFloat currentTitleWidth = [self titleWidthWithIndex:currentIndex];
            CGFloat oldTitleWidth = [self titleWidthWithIndex:previousIndex];
            wDistance = currentTitleWidth - oldTitleWidth;
            CGFloat indicatorViewX = oldTitleView.fj_x + (oldTitleView.fj_width - oldTitleWidth) / 2.0f;
            self.indicatorView.fj_x = indicatorViewX + xDistance * progress;
            self.indicatorView.fj_width = oldTitleWidth + wDistance * progress;
            
        }
    }
    // 固定 宽度
    else if(_segmentViewStyle.segmentIndicatorWidthShowType == FJSegmentIndicatorWidthShowTypeAdaptionFixedWidth) {
        CGFloat oldTitleViewX = oldTitleView.fj_x + (oldTitleView.fj_width - _segmentViewStyle.segmentedIndicatorViewWidth)/2.0;
        CGFloat currentTitleViewX = currentTitleView.fj_x + (currentTitleView.fj_width - _segmentViewStyle.segmentedIndicatorViewWidth)/2.0;
        xDistance = currentTitleViewX - oldTitleViewX;
        self.indicatorView.fj_x = oldTitleViewX + xDistance * progress;
        self.indicatorView.fj_width = _segmentViewStyle.segmentedIndicatorViewWidth;
    }
    

    // 颜色 渐变
    if(_segmentViewStyle.titleLabelChangeType == FJSegmentTitleViewTitleLabelChangeTypeGradualChange) {
        oldTitleView.textColor = [UIColor
                                  colorWithRed:[self.selectedColorRGBA[0] floatValue] + [self.deltaRGBA[0] floatValue] * progress
                                  green:[self.selectedColorRGBA[1] floatValue] + [self.deltaRGBA[1] floatValue] * progress
                                  blue:[self.selectedColorRGBA[2] floatValue] + [self.deltaRGBA[2] floatValue] * progress
                                  alpha:[self.selectedColorRGBA[3] floatValue] + [self.deltaRGBA[3] floatValue] * progress];
       
        
        currentTitleView.textColor = [UIColor
                                      colorWithRed:[self.normalColorRGBA[0] floatValue] - [self.deltaRGBA[0] floatValue] * progress
                                      green:[self.normalColorRGBA[1] floatValue] - [self.deltaRGBA[1] floatValue] * progress
                                      blue:[self.normalColorRGBA[2] floatValue] - [self.deltaRGBA[2] floatValue] * progress
                                      alpha:[self.normalColorRGBA[3] floatValue] - [self.deltaRGBA[3] floatValue] * progress];
        
        CGFloat titleFontProgress = progress;
        
        UIFont *normalFont = _segmentViewStyle.itemTitleFont;
        UIFont *selectedFont = _segmentViewStyle.itemTitleSelectedFont;
        CGFloat fontSpacing = fabs(selectedFont.pointSize - normalFont.pointSize);
        
        NSString *oldTitleFontName = normalFont.fontName;
        NSString *currentTitleFontName = selectedFont.fontName;
        if (progress < _previousProgress) {
            oldTitleFontName = selectedFont.fontName;
            currentTitleFontName = normalFont.fontName;
        }
        
        UIFont *oldTitleProgressFont = [UIFont fontWithName:oldTitleFontName size:selectedFont.pointSize - titleFontProgress * fontSpacing];
        UIFont *currentTitleProgressFont = [UIFont fontWithName:currentTitleFontName size:normalFont.pointSize + titleFontProgress * fontSpacing];
        
       
        [oldTitleView updateTextNormalFont:oldTitleProgressFont];
        [currentTitleView updateTextNormalFont:currentTitleProgressFont];
    }
    
    _previousIndex = currentIndex;
    
    _previousProgress = progress;
}

// 更新 控件 选中 状态
- (void)updateTitleViewSelectedStatus:(NSInteger)selectedIndex {
    
    [_titleCellMarray enumerateObjectsUsingBlock:^(FJSegmentedTagTitleCell *titleView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == selectedIndex) {
            [titleView setSelectedStatus:YES];
        }
        else {
            [titleView setSelectedStatus:NO];
        }
    }];
}

// 依据 索引 更新 控件 状态
- (void)updateControlsStatusWithCurrentIndex:(NSInteger)currentIndex {
    [self updateControlsStatusWithCurrentIndex:currentIndex animated:YES];
}

// 依据 索引 更新 控件 状态
- (void)updateControlsStatusWithCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated {
    
    // 更新 先前 进度
    _previousProgress = 0;
    // 更新 控件 选中 状态
    [self updateTitleViewSelectedStatus:currentIndex];
    
    // 更新 scrollView 位置
    if (self.titleScrollView.contentSize.width != self.titleScrollView.bounds.size.width + _segmentViewStyle.segmentedTagSectionHorizontalEdgeSpacing && self.isBeyondLimitWidth) {// 需要滚动

        FJSegmentedTagTitleCell *currentTitleView = (FJSegmentedTagTitleCell *)_titleCellMarray[currentIndex];
        
        CGFloat offSetx = currentTitleView.center.x - self.fj_width * 0.5;
        if (offSetx < 0) {
            offSetx = 0;
            
        }
        CGFloat maxOffSetX = self.titleScrollView.contentSize.width - self.fj_width;
        
        if (maxOffSetX < 0) {
            maxOffSetX = 0;
        }
        
        if (offSetx > maxOffSetX) {
            offSetx = maxOffSetX;
        }
        
        [self.titleScrollView setContentOffset:CGPointMake(offSetx, 0.0) animated:animated];
    }
    
    // 更新 indicatorView 位置
    if (self.titleCellMarray.count) {
        FJSegmentedTagTitleCell *currentTitleView = (FJSegmentedTagTitleCell *)self.titleCellMarray[currentIndex];
        
        // 宽度 自适应
        if (_segmentViewStyle.segmentIndicatorWidthShowType == FJSegmentIndicatorWidthShowTypeAdaption) {
            if (self.isBeyondLimitWidth) {
                self.indicatorView.fj_x = currentTitleView.fj_x;
                self.indicatorView.fj_width = currentTitleView.fj_width;
            }
            else {
                CGFloat currentTitleWidth = [self titleWidthWithIndex:currentIndex];
                CGFloat indicatorViewX = currentTitleView.fj_x + (currentTitleView.fj_width - currentTitleWidth) / 2.0f;
                self.indicatorView.fj_x = indicatorViewX;
                self.indicatorView.fj_width = currentTitleWidth;
            }
        }
        // 固定 宽度
        else if(_segmentViewStyle.segmentIndicatorWidthShowType == FJSegmentIndicatorWidthShowTypeAdaptionFixedWidth) {
            self.indicatorView.fj_x = (currentTitleView.fj_width - _segmentViewStyle.segmentedIndicatorViewWidth)/2.0f + currentTitleView.fj_x;
            self.indicatorView.fj_width = _segmentViewStyle.segmentedIndicatorViewWidth;
        }
    }
     _selectedIndex = currentIndex;
}


// 标题 宽度
- (CGFloat)titleWidthWithIndex:(NSUInteger)index {
    NSString *tagTitle = [self.tagTitleArray objectAtIndex:index];
    CGFloat titleWidth = [tagTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[self correctCalculateFont]} context:nil].size.width;
    return titleWidth + _segmentViewStyle.segmentedIndicatorViewExtendWidth;
}

// 用于 计算 的 字体
- (UIFont *)correctCalculateFont {
    // 如果
    if (_segmentViewStyle.itemTitleFont.pointSize > _segmentViewStyle.itemTitleSelectedFont.pointSize) {
        return _segmentViewStyle.itemTitleFont;
    }
    else {
        return _segmentViewStyle.itemTitleSelectedFont;
    }
}

#pragma mark --------------- Private Methods
// 设置 子控件
- (void)setupControls {
    _segmentViewStyle = [[FJSegmentViewStyle alloc] init];
    [self addSubview:self.titleScrollView];
    [self addSubview:self.bottomLineView];
    [self.titleScrollView addSubview:self.indicatorView];
}



// 生成 titleCellFrameMarry
- (void)generateTitleCellFrameMarray:(NSArray *)tagTitleArray {
    [self.titleCellFrameMarray removeAllObjects];
    if (tagTitleArray.count) {
        // 如果 超过 屏幕
        if (self.isBeyondLimitWidth) {
             __block  CGFloat tmpOffsetX = _segmentViewStyle.segmentedTagSectionHorizontalEdgeSpacing;
            [tagTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGFloat titleViewWidth = [self titleWidthWithIndex:idx];
                [self.titleCellFrameMarray addObject:NSStringFromCGRect(CGRectMake(tmpOffsetX, 0, titleViewWidth, self.fj_height))];
                tmpOffsetX += _segmentViewStyle.segmentedTagSectionCellSpacing + titleViewWidth;
            }];
            
        }
        // 不超过 屏幕
        else {
            [tagTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGFloat titleViewWidth = self.frame.size.width / self.tagTitleArray.count;;
                [self.titleCellFrameMarray addObject:NSStringFromCGRect(CGRectMake(idx * titleViewWidth, 0, titleViewWidth, self.fj_height))];
            }];
        }
    }
}

// 标题 总长度
- (CGFloat)titleTotalWidth {
    __block CGFloat tmpTitleTotalWidth = 0;
    [self.titleWidthMarray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        tmpTitleTotalWidth += obj.floatValue;
    }];
    return tmpTitleTotalWidth;
}
// 生成 scrollView 的 子view
- (void)generateTitleCellsWithTitleArray:(NSArray *)titleArray {
    if (titleArray.count) {
        [self.titleScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[FJSegmentedTagTitleCell class]]) {
                [obj removeFromSuperview];
            }
        }];
        
        [self.titleCellMarray removeAllObjects];
        
        [titleArray enumerateObjectsUsingBlock:^(NSString *titleString, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect tmpFrame = CGRectFromString(self.titleCellFrameMarray[idx]);
            FJSegmentedTagTitleCell *cell = [[FJSegmentedTagTitleCell alloc] init];
            cell.frame = tmpFrame;
            cell.segmentViewStyle = self.segmentViewStyle;
            cell.fj_height = self.segmentViewStyle.segmentedTitleViewHeight;
            cell.titleStr = titleString;
            cell.tag = idx;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewClicked:)];
            [cell addGestureRecognizer:tapGesture];
            
            [self.titleCellMarray addObject:cell];
            [self.titleScrollView addSubview:cell];
            
            if (idx == (self.titleCellFrameMarray.count - 1)) {
                self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(tmpFrame) + _segmentViewStyle.segmentedTagSectionHorizontalEdgeSpacing, 0.0);
            }
        }];

    }
}

// 更新 控件
- (void)updateControlsLayout {
    
    self.indicatorView.hidden = NO;
    [self updateControlsStatusWithCurrentIndex:_selectedIndex];
}



// 是否 超过 屏幕 宽度 限制
- (void)beyondWidthLimitWithTitleArray:(NSArray *)titleArray {
    if (self.segmentViewStyle.forbidSectionViewDivideWidth) {
        self.isBeyondLimitWidth = YES;
    }
    else {
        self.isBeyondLimitWidth = NO;
        [self.titleWidthMarray removeAllObjects];
        __block CGFloat tmpTotalWidth = _segmentViewStyle.segmentedTagSectionCellSpacing;
        [titleArray enumerateObjectsUsingBlock:^(NSString *tmpTitle, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tmpTitleviewWidth = [self titleWidthWithIndex:idx];
            [self.titleWidthMarray addObject:[NSNumber numberWithFloat:tmpTitleviewWidth]];
            tmpTotalWidth += tmpTitleviewWidth;
        }];
        
        if (tmpTotalWidth > self.frame.size.width) {
            self.isBeyondLimitWidth = YES;
        }
    }
}


- (void)setDidSelectItemDelegateWay {
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleSectionView:clickIndex:)]) {
        [self.delegate titleSectionView:self clickIndex:_selectedIndex];
    }
}

#pragma mark --------------- Response Event
// 点击 titleView
- (void)titleViewClicked:(UITapGestureRecognizer *)tapGesture {
    FJSegmentedTagTitleCell *currentLabel = (FJSegmentedTagTitleCell *)tapGesture.view;
    if (!currentLabel) {
        return;
    }
    _selectedIndex = currentLabel.tag;
    
    [self setDidSelectItemDelegateWay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateControlsStatusWithCurrentIndex:_selectedIndex];
    });
}



#pragma mark --------------- Getter / Setter
// 设置 选中 索引
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _previousIndex = _selectedIndex;
    _selectedIndex = selectedIndex;

    [[NSNotificationCenter defaultCenter] postNotificationName:kFJScrollToSegmentedPageNoti object:[NSNumber numberWithUnsignedInteger:selectedIndex]];
}

// 设置 数据源
- (void)setSegmentPageDataSource:(id<FJSegmentPageViewDataSource>)segmentPageDataSource {
    _segmentPageDataSource = segmentPageDataSource;
    if (segmentPageDataSource) {
        [self reloadData];
    }
}

// 设置 标题 数组
- (void)setTagTitleArray:(NSArray *)tagTitleArray {
    _tagTitleArray = tagTitleArray;
    if (_tagTitleArray.count) {
        [self beyondWidthLimitWithTitleArray:tagTitleArray];
        [self generateTitleCellFrameMarray:tagTitleArray];
        [self generateTitleCellsWithTitleArray:tagTitleArray];
        [self updateControlsLayout];
    }
}

// 设置 高度
- (void)setTagSectionViewHeight:(CGFloat)tagSectionViewHeight {
    _tagSectionViewHeight = tagSectionViewHeight;
    
    self.fj_height = tagSectionViewHeight;
    self.titleScrollView.fj_height = self.fj_height;
    self.indicatorView.fj_y = self.frame.size.height - _segmentViewStyle.segmentedIndicatorViewHeight - self.bottomLineView.frame.size.height;
    
    self.bottomLineView.fj_y = self.frame.size.height - _segmentViewStyle.separatorLineHeight;;
}

// 配置 属性
- (void)setSegmentViewStyle:(FJSegmentViewStyle *)segmentViewStyle {
    _segmentViewStyle = segmentViewStyle;
    if (_segmentViewStyle) {
        
        self.selectedIndex = segmentViewStyle.selectedIndex;
        self.tagSectionViewHeight = segmentViewStyle.segmentedTitleViewHeight;
        self.backgroundColor = segmentViewStyle.segmentToolbackgroundColor;
        
        self.fj_width = _segmentViewStyle.segmentedTitleViewWidth;
        
        // bottomLineView
        CGFloat indicatorWidth = _segmentViewStyle.segmentedIndicatorViewWidth;
        CGFloat indicatorHeight = _segmentViewStyle.segmentedIndicatorViewHeight;
        _bottomLineView.frame = CGRectMake(0, self.frame.size.height - _segmentViewStyle.separatorLineHeight, self.frame.size.width, _segmentViewStyle.separatorLineHeight);
        _bottomLineView.backgroundColor = _segmentViewStyle.separatorBackgroundColor;
        
        // indicatorView
        CGFloat indicatorViiewY = self.frame.size.height - indicatorHeight - self.bottomLineView.frame.size.height - _segmentViewStyle.segmentedIndicatorViewToBottomSpacing;
        _indicatorView.frame = CGRectMake(_segmentViewStyle.segmentedTagSectionHorizontalEdgeSpacing, indicatorViiewY, indicatorWidth, indicatorHeight);
        _indicatorView.backgroundColor = _segmentViewStyle.indicatorViewBackgroundColor;
        
        // titleScrollView
        self.titleScrollView.fj_width = self.fj_width;
    }
}


// 标题 宽度
- (NSMutableArray <NSNumber *>*)titleWidthMarray {
    if(!_titleWidthMarray){
        _titleWidthMarray = [[NSMutableArray alloc] init];
    }
    return  _titleWidthMarray;
}

// 标题 cell 数组
- (NSMutableArray *)titleCellMarray {
    if (!_titleCellMarray) {
        _titleCellMarray = [NSMutableArray array];
    }
    return _titleCellMarray;
}

// 标题 cell frame 数组
- (NSMutableArray *)titleCellFrameMarray {
    if(!_titleCellFrameMarray){
        _titleCellFrameMarray = [[NSMutableArray alloc] init];
    }
    return  _titleCellFrameMarray;
}


// 标题栏 titleScrollView
- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , self.frame.size.height)];
        _titleScrollView.pagingEnabled = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.delegate = self;
    }
    return _titleScrollView;
}


// 指示器
- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat indicatorWidth = _segmentViewStyle.segmentedIndicatorViewWidth;
        CGFloat indicatorHeight = _segmentViewStyle.segmentedIndicatorViewHeight;
        CGFloat indicatorY = self.frame.size.height - indicatorHeight - self.bottomLineView.frame.size.height - _segmentViewStyle.segmentedIndicatorViewToBottomSpacing;
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(_segmentViewStyle.segmentedTagSectionHorizontalEdgeSpacing, indicatorY, indicatorWidth, indicatorHeight)];
        _indicatorView.backgroundColor = _segmentViewStyle.indicatorViewBackgroundColor;
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}



// 底部 分割线
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - _segmentViewStyle.separatorLineHeight, self.frame.size.width, _segmentViewStyle.separatorLineHeight)];
        _bottomLineView.backgroundColor = _segmentViewStyle.separatorBackgroundColor;
    }
    return _bottomLineView;
}


- (NSArray *)deltaRGBA {
    if (_deltaRGBA == nil) {
        NSArray *normalColorRgb = self.normalColorRGBA;
        NSArray *selectedColorRgb = self.selectedColorRGBA;
        
        NSArray *delta;
        if (normalColorRgb && selectedColorRgb) {
            CGFloat deltaR = [normalColorRgb[0] floatValue] - [selectedColorRgb[0] floatValue];
            CGFloat deltaG = [normalColorRgb[1] floatValue] - [selectedColorRgb[1] floatValue];
            CGFloat deltaB = [normalColorRgb[2] floatValue] - [selectedColorRgb[2] floatValue];
            CGFloat deltaA = [normalColorRgb[3] floatValue] - [selectedColorRgb[3] floatValue];
            delta = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
            _deltaRGBA = delta;
            
        }
    }
    return _deltaRGBA;
}

- (NSArray *)normalColorRGBA {
    if (!_normalColorRGBA) {
        NSArray *normalColorRGBA = [self getColorRGBA:self.segmentViewStyle.itemTitleColorStateNormal];
        NSAssert(normalColorRGBA, @"设置普通状态的文字颜色时 请使用RGBA空间的颜色值");
        _normalColorRGBA = normalColorRGBA;
        
    }
    return  _normalColorRGBA;
}

- (NSArray *)selectedColorRGBA {
    if (!_selectedColorRGBA) {
        NSArray *selectedColorRGBA = [self getColorRGBA:self.segmentViewStyle.itemTitleColorStateSelected];
        NSAssert(selectedColorRGBA, @"设置选中状态的文字颜色时 请使用RGBA空间的颜色值");
        _selectedColorRGBA = selectedColorRGBA;
        
    }
    return  _selectedColorRGBA;
}

- (NSArray *)getColorRGBA:(UIColor *)color {
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbaComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbaComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), @(components[3]), nil];
    }
    return rgbaComponents;
    
}
@end
