//
//  FJDetailContentView.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentedPageDefine.h"
#import "FJSegmentedPageContentView.h"
#import "FJPageCollectionViewCell.h"
#import "FJSegmentdPageViewController.h"


@interface FJSegmentedPageContentView()<UICollectionViewDataSource, UICollectionViewDelegate>
// page collection
@property (nonatomic, strong) UICollectionView *pageCollectionView;
// page flowLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *pageFlowLayout;
@end

@implementation FJSegmentedPageContentView

#pragma mark --- init method

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.pageCollectionView];
    }
    return self;
}

#pragma makr --- private method

- (void)generateViewControllerArrayWithViewArray:(NSArray *)viewArray {

    if (self.viewControllerArray.count == 0) {
        [viewArray enumerateObjectsUsingBlock:^(FJConfigModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class clazz = NSClassFromString(obj.viewControllerStr);
            FJSegmentdPageViewController *baseViewController = [[clazz alloc] init];
            baseViewController.currentIndex = idx;
            baseViewController.pageViewControllerParam = obj.pageViewControllerParam;
            [self.viewControllerArray addObject:baseViewController];
        }];
    }
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
    FJPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFJPageCollectionViewCellId forIndexPath:indexPath];
    FJSegmentdPageViewController *baseViewController = self.viewControllerArray[indexPath.row];
    [cell configCellWithViewController:baseViewController];
    return cell;
}


/***************************** UIScrollViewDelegate *************************/

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.pageCollectionView.frame.size.width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(detailContentView:selectedIndex:)]) {
        [self.delegate detailContentView:self selectedIndex:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger index = (NSInteger)roundf(scrollView.contentOffset.x / self.pageCollectionView.frame.size.width);
    if (self.delegate && [self.delegate respondsToSelector:@selector(detailContentView:selectedIndex:)]) {
        [self.delegate detailContentView:self selectedIndex:index];
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
    }
}
// 设置 tagSectionViewHeight
- (void)setTagSectionViewHeight:(CGFloat)tagSectionViewHeight {
    _tagSectionViewHeight = tagSectionViewHeight;
    [self.viewControllerArray enumerateObjectsUsingBlock:^(FJSegmentdPageViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tagSectionViewHeight = _tagSectionViewHeight;
    }];
}

// 设置 viewController 参数
- (void)setBaseViewControllerParam:(id)baseViewControllerParam {
    _baseViewControllerParam = baseViewControllerParam;
    [self.viewControllerArray enumerateObjectsUsingBlock:^(FJSegmentdPageViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.baseViewControllerParam = baseViewControllerParam;
    }];
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
        [_pageCollectionView registerClass:[FJPageCollectionViewCell class] forCellWithReuseIdentifier:kFJPageCollectionViewCellId];
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
