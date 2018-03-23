//
//  FJDetailContentView.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentViewStyle.h"
#import "FJSegmentedPageDefine.h"
#import "FJSegmentedPageContentView.h"
#import "FJPageCollectionViewCell.h"
#import "FJSegmentdPageViewController.h"


@interface FJSegmentedPageContentView()<UICollectionViewDataSource, UICollectionViewDelegate> {
    
    CGFloat _oldIndex;
    CGFloat _oldOffSetX;
    CGFloat _currentIndex;
}

// 标题 栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// 消除 子类 滚动 限制
@property (nonatomic, assign) BOOL eliminateSubViewScrollLimit;
// page collection
@property (nonatomic, strong) UICollectionView *pageCollectionView;
// page flowLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *pageFlowLayout;
@end

@implementation FJSegmentedPageContentView

#pragma mark --- init method

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        [self setupViewControls];
        [self setupDefaultValues];
    }
    return self;
}

#pragma makr --- private method

// 设置 子控件
- (void)setupViewControls {
    [self addSubview:self.pageCollectionView];
}

// 设置 默认 值
- (void)setupDefaultValues {
    _oldIndex = -1;
    _currentIndex = 0;
    _oldOffSetX = 0.0f;
}

- (void)generateViewControllerArrayWithViewArray:(NSArray *)viewArray {

    if (self.viewControllerArray.count != viewArray.count) {
        [viewArray enumerateObjectsUsingBlock:^(FJConfigModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class clazz = NSClassFromString(obj.viewControllerStr);
            FJSegmentdPageViewController *baseViewController = [[clazz alloc] init];
            baseViewController.currentIndex = idx;
            baseViewController.pageViewControllerParam = obj.pageViewControllerParam;
            [self.viewControllerArray addObject:baseViewController];
        }];
    }
}

// 设置 参数
- (void)setSegmentPageViewControllerParam {
    [self.viewControllerArray enumerateObjectsUsingBlock:^(FJSegmentdPageViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.eliminateSubViewScrollLimit = _eliminateSubViewScrollLimit;
        obj.baseViewControllerParam = _baseViewControllerParam;
        obj.tagSectionViewHeight = _tagSectionViewHeight;
    }];
}


#pragma mark --- system delegate

/***************************** UICollectionViewDataSource *************************/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.detailContentViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //页面
    FJPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FJPageCollectionViewCell class]) forIndexPath:indexPath];
    FJSegmentdPageViewController *baseViewController = self.viewControllerArray[indexPath.row];
    [cell configCellWithViewController:baseViewController];
    return cell;
}


/***************************** UIScrollViewDelegate *************************/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _oldOffSetX = scrollView.contentOffset.x;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat tempProgress = scrollView.contentOffset.x / self.bounds.size.width;
    NSInteger tempIndex = tempProgress;
    
    CGFloat progress = tempProgress - floor(tempProgress);
    CGFloat deltaX = scrollView.contentOffset.x - _oldOffSetX;
    
    if (deltaX > 0) {// 向左
        if (progress == 0.0) {
            return;
        }
        _currentIndex = tempIndex+1;
        _oldIndex = tempIndex;
    }
    // 向右
    else if (deltaX < 0) {
        progress = 1.0 - progress;
        _oldIndex = tempIndex+1;
        _currentIndex = tempIndex;
    }
    else {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(detailContentView:previousIndex:currentIndex:progress:)]) {
        [self.delegate detailContentView:self previousIndex:_oldIndex currentIndex:_currentIndex progress:progress];
    }
}


/** 滚动减速完成时再更新title的位置 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger currentIndex = (scrollView.contentOffset.x / self.bounds.size.width);
    if (self.delegate && [self.delegate respondsToSelector:@selector(detailContentView:previousIndex:currentIndex:progress:)]) {
        [self.delegate detailContentView:self previousIndex:currentIndex currentIndex:currentIndex progress:1.0];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(detailContentView:currentIndex:)]) {
        [self.delegate detailContentView:self currentIndex:currentIndex];
    }
}

#pragma mark --- setter method
// 设置 选中 索引
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (CGSizeEqualToSize(self.pageCollectionView.contentSize, CGSizeZero)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              [self.pageCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        });
    }
    else {
        [self.pageCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}

// 内容 viewArray
- (void)setDetailContentViewArray:(NSArray *)detailContentViewArray {
    _detailContentViewArray = detailContentViewArray;
    if (_detailContentViewArray.count > 0) {
        [self generateViewControllerArrayWithViewArray:_detailContentViewArray];
        [self.pageCollectionView reloadData];
        [self setSegmentPageViewControllerParam];
    }
}

// 设置 viewController 参数
- (void)setBaseViewControllerParam:(id)baseViewControllerParam {
    _baseViewControllerParam = baseViewControllerParam;
     [self setSegmentPageViewControllerParam];
}


- (void)setSegmentViewStyle:(FJSegmentViewStyle *)segmentViewStyle {
    _segmentViewStyle = segmentViewStyle;
    if (segmentViewStyle) {
        self.selectedIndex = segmentViewStyle.selectedIndex;
        self.eliminateSubViewScrollLimit = segmentViewStyle.eliminateSubViewScrollLimit;
        self.tagSectionViewHeight = segmentViewStyle.tagSectionViewHeight;
        [self setSegmentPageViewControllerParam];
    }
}
#pragma mark --- getter method

// viewControll array
- (NSMutableArray <FJSegmentdPageViewController *>*)viewControllerArray {
    if (!_viewControllerArray) {
        _viewControllerArray = [NSMutableArray array];
    }
    return _viewControllerArray;
}

// page flowLayout
- (UICollectionViewFlowLayout *)pageFlowLayout {
    if (!_pageFlowLayout) {
        _pageFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _pageFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _pageFlowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        _pageFlowLayout.minimumLineSpacing = 0;
        _pageFlowLayout.minimumInteritemSpacing = 0;
    }
    return _pageFlowLayout;
}


// page collectionView
- (UICollectionView *)pageCollectionView {
    if (!_pageCollectionView) {
       _pageCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.pageFlowLayout];
        [_pageCollectionView registerClass:[FJPageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FJPageCollectionViewCell class])];
        _pageCollectionView.showsHorizontalScrollIndicator = NO;
        _pageCollectionView.dataSource = self;
        _pageCollectionView.delegate = self;
        _pageCollectionView.bounces = NO;
        _pageCollectionView.pagingEnabled = YES;
        _pageCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _pageCollectionView;
}
@end
