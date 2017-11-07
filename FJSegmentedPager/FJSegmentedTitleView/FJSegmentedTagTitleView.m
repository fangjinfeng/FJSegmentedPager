

//
//  FJTitleTagSectionView.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentedTagTitleView.h"
#import "FJSegmentedPageDefine.h"
#import "FJSegmentedTagTitleCell.h"




@interface FJSegmentedTagTitleView()<UICollectionViewDelegate, UICollectionViewDataSource>
// 指示器 indicator
@property (nonatomic, strong) UIView *indicatorView;
// 分割 view
@property (nonatomic, strong) UIView *bottomLineView;
// 先前 选中 索引
@property (nonatomic, assign) NSUInteger previousIndex;
// 是否 超过 宽度 限制
@property (nonatomic, assign) BOOL isBeyondLimitWidth;
// 标签 collectionView
@property (nonatomic, strong) UICollectionView *tagCollectionView;
// 标签 flowLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *tagFlowLayout;

@end

@implementation FJSegmentedTagTitleView

#pragma mark --- init method
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultValuse];
        [self setupControls];
    }
    return self;
}

#pragma mark --- private method
// 设置 子控件
- (void)setupControls {
    [self addSubview:self.indicatorView];
    [self addSubview:self.tagCollectionView];
    [self addSubview:self.bottomLineView];
}

// 设置 默认值
- (void)setupDefaultValuse {
    self.indicatorWidth = kFJSegmentedIndicatorViewWidth;
    self.indicatorHeight = kFJSegmentedIndicatorViewHeight;
    self.tagItemSize = CGSizeMake(kFJSegmentedTitleViewTitleWidth, self.frame.size.height);
}

// 更新 tagItemSize
- (void)updateItemSizeWithTitleArray:(NSArray *)titleArray {
    
    if (self.isBeyondLimitWidth == NO) {
        self.tagItemSize = CGSizeMake(self.frame.size.width / titleArray.count, self.frame.size.height);
    }
    else {
        self.tagFlowLayout.minimumLineSpacing = kFJSegmentedTagSectionCellSpacing; //最小线间距
        self.tagFlowLayout.minimumInteritemSpacing = kFJSegmentedTagSectionCellSpacing;
    }
    self.tagFlowLayout.itemSize = self.tagItemSize;
    CGRect indicatorViewFrame = self.indicatorView.frame;
    indicatorViewFrame.origin.x = [self indicatorX];
    self.indicatorView.frame = indicatorViewFrame;
    self.selectedIndex  = _selectedIndex;
    self.indicatorView.hidden = NO;
    [self.tagCollectionView reloadData];
}



// 是否 超过 屏幕 宽度 限制
- (void)beyondWidthLimitWithTitleArray:(NSArray *)titleArray {
    self.isBeyondLimitWidth = NO;
    __block CGFloat tmpWidth = kFJSegmentedTagSectionCellSpacing;
    [titleArray enumerateObjectsUsingBlock:^(NSString *tmpTitle, NSUInteger idx, BOOL * _Nonnull stop) {
        tmpWidth += [self titleWidthWithIndex:idx];
    }];
    
    if (tmpWidth > self.frame.size.width) {
        self.isBeyondLimitWidth = YES;
    }
}


#pragma mark --- public method


- (void)updateIndicatorWidthWithIndex:(NSInteger)currentIndex {
    
    [self.tagCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    FJSegmentedTagTitleCell *previousCell = (FJSegmentedTagTitleCell *)[self.tagCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.previousIndex inSection:0]];
    [previousCell setSelectedStatus:NO];
    
    FJSegmentedTagTitleCell *cell = (FJSegmentedTagTitleCell *)[self.tagCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0]];
    [cell setSelectedStatus:YES];
    
    CGRect convertRect = [self.tagCollectionView convertRect:cell.frame toView:self];
    
    CGFloat indicatorViewX = CGRectGetMinX(convertRect);
    if (self.isBeyondLimitWidth == NO) {
        CGFloat cellWidth = self.frame.size.width / self.tagTitleArray.count;
        indicatorViewX = cellWidth * currentIndex + cellWidth/2.0 - self.indicatorView.frame.size.width/2.0;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = CGRectMake(indicatorViewX, self.indicatorView.frame.origin.y, [self titleWidthWithIndex:currentIndex], self.indicatorView.frame.size.height);
    }];
}



// 标题 宽度
- (CGFloat)titleWidthWithIndex:(NSUInteger)index {
    
    NSString *tagTitle = [self.tagTitleArray objectAtIndex:index];
    
    CGFloat titleWidth = [tagTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFJSegmentedTitleFontSize} context:nil].size.width;
    return titleWidth + kFJSegmentedIndicatorViewExtendWidth;
}




#pragma mark --- system delegate

/***************************** UICollectionViewDataSource *************************/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagTitleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FJSegmentedTagTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFJTagCollectionViewCellId forIndexPath:indexPath];
    cell.titleStr = self.tagTitleArray[indexPath.item];
    [cell setSelectedStatus:(self.selectedIndex == indexPath.item)?YES:NO];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize tmpSize = CGSizeZero;
    if (self.isBeyondLimitWidth == NO) {
        tmpSize = CGSizeMake(self.frame.size.width / self.tagTitleArray.count, self.frame.size.height);
    }
    else {
         tmpSize = CGSizeMake([self titleWidthWithIndex:indexPath.row], self.frame.size.height);
    }
    return tmpSize;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat edgeSpacing = 0;
    if (self.isBeyondLimitWidth) {
        edgeSpacing = kFJSegmentedTagSectionHorizontalEdgeSpacing;
    }
    return UIEdgeInsetsMake(0, edgeSpacing, 0, edgeSpacing);
}



/***************************** UICollectionViewDelegate *************************/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    _selectedIndex = indexPath.item;
    [self setDidSelectItemDelegateWay];
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [(FJSegmentedTagTitleCell *)cell setSelectedStatus:(self.selectedIndex == indexPath.item) ? YES:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [(FJSegmentedTagTitleCell *)cell setSelectedStatus:(self.selectedIndex == indexPath.item) ? YES:NO];
}



- (void)setDidSelectItemDelegateWay {
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleSectionView:clickIndex:)]) {
        [self.delegate titleSectionView:self clickIndex:_selectedIndex];
    }
}



#pragma mark --- setter method
// 设置 选中 索引
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _previousIndex = _selectedIndex;
    _selectedIndex = selectedIndex;

    if (CGSizeEqualToSize(self.tagCollectionView.contentSize, CGSizeZero)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateIndicatorWidthWithIndex:selectedIndex];
        });
    }
    else {
        if (self.tagCollectionView.contentSize.width > self.tagItemSize.width && _selectedIndex < self.tagTitleArray.count) {
            [self updateIndicatorWidthWithIndex:selectedIndex];
        }
    }
     [[NSNotificationCenter defaultCenter] postNotificationName:kFJScrollToSegmentedPageNoti object:[NSNumber numberWithUnsignedInteger:selectedIndex]];
}


// 设置 标题 数组
- (void)setTagTitleArray:(NSArray *)tagTitleArray {
    _tagTitleArray = tagTitleArray;
    if (_tagTitleArray.count) {
        [self beyondWidthLimitWithTitleArray:tagTitleArray];
        [self updateItemSizeWithTitleArray:_tagTitleArray];
    }
}

// 设置 高度
- (void)setTagSectionViewHeight:(CGFloat)tagSectionViewHeight {
    
    CGRect segmentedTitleRect = self.frame;
    segmentedTitleRect.size.height = tagSectionViewHeight;
    self.frame = segmentedTitleRect;
    
    CGRect indicatorViewFrame = self.indicatorView.frame;
    indicatorViewFrame.origin.y = self.frame.size.height - self.indicatorHeight - self.bottomLineView.frame.size.height;
    self.indicatorView.frame = indicatorViewFrame;
    
    CGRect bottomLineViewFrame = self.bottomLineView.frame;
    bottomLineViewFrame.origin.y = self.frame.size.height - kFJSegmentedBottomLineViewHeight;
    self.bottomLineView.frame = bottomLineViewFrame;
}

#pragma mark --- getter method

- (CGFloat)indicatorX {
    CGFloat indicatorViewX = 0;
    if (self.selectedIndex == 0) {
        indicatorViewX = kFJSegmentedTagSectionHorizontalEdgeSpacing - kFJSegmentedIndicatorViewExtendWidth/2.0;
    }
    else if(self.selectedIndex < (self.tagTitleArray.count - 1)){
        indicatorViewX = 0;
    }
    else if(self.selectedIndex == (self.tagTitleArray.count - 1)){
        indicatorViewX = kFJSegmentedTagSectionHorizontalEdgeSpacing - kFJSegmentedIndicatorViewExtendWidth/2.0;
    }
    return indicatorViewX;
}

// 指示器
- (UIView *)indicatorView {
    if (!_indicatorView) {
        
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake([self indicatorX], self.frame.size.height - self.indicatorHeight - self.bottomLineView.frame.size.height, self.indicatorWidth, self.indicatorHeight)];
        _indicatorView.backgroundColor = kFJSegmentedIndicatorViewColor;
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

// 标签 flowLayout
- (UICollectionViewLayout *)tagFlowLayout {
    if (!_tagFlowLayout) {
        _tagFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        _tagFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滚动方向  水平方向
        _tagFlowLayout.itemSize = self.tagItemSize;
        _tagFlowLayout.minimumLineSpacing = 0; //最小线间距
        _tagFlowLayout.minimumInteritemSpacing = 0;
    }
    return _tagFlowLayout;
}

// 标签 collectionView
- (UICollectionView *)tagCollectionView {
    if (!_tagCollectionView) {
        _tagCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.tagFlowLayout];
        [_tagCollectionView registerClass:[FJSegmentedTagTitleCell class] forCellWithReuseIdentifier:kFJTagCollectionViewCellId];
        _tagCollectionView.dataSource = self;
        _tagCollectionView.delegate = self;
        _tagCollectionView.pagingEnabled = YES;
        _tagCollectionView.backgroundColor = [UIColor clearColor];
        _tagCollectionView.showsHorizontalScrollIndicator = NO;//显示水平滚动指标
    }
    return _tagCollectionView;
}

// 底部 分割线
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kFJSegmentedBottomLineViewHeight, self.frame.size.width, kFJSegmentedBottomLineViewHeight)];
        _bottomLineView.backgroundColor = kFJBottomLineViewBackgroundColor;
    }
    return _bottomLineView;
}

@end
