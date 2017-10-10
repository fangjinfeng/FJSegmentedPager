

//
//  FJTitleTagSectionView.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJTitleTagSectionView.h"
#import "FJDoubleDeckRollDefine.h"
#import "FJTagCollectionViewCell.h"




@interface FJTitleTagSectionView()<UICollectionViewDelegate, UICollectionViewDataSource>
// 指示器 indicator
@property (nonatomic, strong) UIView *indicatorView;
// 分割 view
@property (nonatomic, strong) UIView *bottomLineView;
// 标签 collectionView
@property (nonatomic, strong) UICollectionView *tagCollectionView;
// 标签 flowLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *tagFlowLayout;

@end

@implementation FJTitleTagSectionView

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
    self.tagItemSize = CGSizeMake(kFJTitleTagSectionTitleWidth, self.frame.size.height);
}

// 更新 tagItemSize
- (void)updateItemSizeWithTitleArray:(NSArray *)titleArray {
    self.tagItemSize = CGSizeMake(self.frame.size.width / titleArray.count, self.frame.size.height);
    self.tagFlowLayout.itemSize = self.tagItemSize;
    CGRect indicatorViewFrame = self.indicatorView.frame;
    indicatorViewFrame.origin.x = [self indicatorX];
    self.indicatorView.frame = indicatorViewFrame;
    self.selectedIndex  = _selectedIndex;
    self.indicatorView.hidden = NO;
    [self.tagCollectionView reloadData];
}

// 更新 指示view  宽度
- (void)updateIndicatorWidthWithSelectedIndex:(NSInteger)selectedIndex {
    NSString *tagTitle = [self.tagTitleArray objectAtIndex:selectedIndex];
    
    CGFloat titleWidth = [tagTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFJSegmentedTitleFontSize} context:nil].size.width;
    
    self.indicatorWidth = titleWidth + 5;
      CGRect indicatorViewFrame = self.indicatorView.frame;
    indicatorViewFrame.size.width = self.indicatorWidth;
    self.indicatorView.frame = indicatorViewFrame;
    [self updateIndicatorView:selectedIndex * self.frame.size.width];
}




#pragma mark --- public method

// 更新 指示器 值
- (void)updateIndicatorView:(CGFloat)contentOffsetX {
    CGFloat fromX = [self indicatorX];
    CGFloat selectionIndicatorX = (contentOffsetX / self.frame.size.width) * self.tagItemSize.width + fromX;
    CGRect indicatorViewFrame = self.indicatorView.frame;
    indicatorViewFrame.origin.x = selectionIndicatorX;
    self.indicatorView.frame = indicatorViewFrame;
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
    FJTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFJTagCollectionViewCellId forIndexPath:indexPath];
    cell.titleStr = self.tagTitleArray[indexPath.item];
    [cell setSelected:(self.selectedIndex == indexPath.item)?YES:NO];
    return cell;
}

/***************************** UICollectionViewDelegate *************************/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.item;
    [self setDidSelectItemDelegateWay];
}

- (void)setDidSelectItemDelegateWay {
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleSectionView:clickIndex:)]) {
        [self.delegate titleSectionView:self clickIndex:_selectedIndex];    }
}

#pragma mark --- setter method
// 设置 选中 索引
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;

    if (CGSizeEqualToSize(self.tagCollectionView.contentSize, CGSizeZero)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tagCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
            [self updateIndicatorWidthWithSelectedIndex:selectedIndex];
        });
    }
    else {
        if (self.tagCollectionView.contentSize.width > self.tagItemSize.width && _selectedIndex < self.tagTitleArray.count) {
            [self.tagCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
            [self updateIndicatorWidthWithSelectedIndex:selectedIndex];
        }
    }
}


// 设置 标题 数组
- (void)setTagTitleArray:(NSArray *)tagTitleArray {
    _tagTitleArray = tagTitleArray;
    if (_tagTitleArray.count) {
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
    return self.tagItemSize.width/2.0 - self.indicatorWidth/2.0;
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
        _tagFlowLayout.minimumLineSpacing = 0.0f; //最小线间距
        _tagFlowLayout.minimumInteritemSpacing = 0.0f;
    }
    return _tagFlowLayout;
}

// 标签 collectionView
- (UICollectionView *)tagCollectionView {
    if (!_tagCollectionView) {
        _tagCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.tagFlowLayout];
        [_tagCollectionView registerClass:[FJTagCollectionViewCell class] forCellWithReuseIdentifier:kFJTagCollectionViewCellId];
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
