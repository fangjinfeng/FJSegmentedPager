//
//  FJDetailContentView.m
//  FJDoubleDeckRollViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

// tool
#import "FJSegmentViewStyle.h"
#import "FJSegmentedPageDefine.h"
// view
#import "FJSegmentedPageContentView.h"
// vc
#import "FJSegmentdPageViewController.h"
// category
#import "UIViewController+FJCurrentViewController.h"


@interface FJSegmentedPageContentView()<UICollectionViewDataSource, UICollectionViewDelegate> {
    
    NSInteger _oldIndex;
    CGFloat _oldOffSetX;
    NSInteger _currentIndex;
    BOOL _isLoadFirstView;
}

// 自视图 个数
@property (assign, nonatomic) NSInteger childVcCount;
// 滚动超过页面(直接设置contentOffSet导致)
@property (assign, nonatomic) BOOL scrollOverOnePage;
// 是否需要手动管理生命周期方法的调用
@property (assign, nonatomic) BOOL needManageLifeCycle;
// 当这个属性设置为YES的时候 就不用处理 scrollView滚动的计算
@property (assign, nonatomic) BOOL forbidTouchToAdjustPosition;
// 父类 用于处理添加子控制器  使用weak避免循环引用
@property (weak, nonatomic) UIViewController *parentViewController;
// page collection
@property (nonatomic, strong) UICollectionView *pageCollectionView;
// page flowLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *pageFlowLayout;

// 存储 自控制器
@property (strong, nonatomic) NSMutableDictionary<NSString *, UIViewController<FJSegmentPageChildVcDelegate> *> *childVcsDic;

// 当前 控制器
@property (strong, nonatomic) UIViewController<FJSegmentPageChildVcDelegate> *currentChildVc;
@end

@implementation FJSegmentedPageContentView

#pragma mark -------------------------- Life Circle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if DEBUG
    NSLog(@"FJSegmentedPageContentView---销毁");
#endif
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self setupDefaultValues];
    }
    return self;
}


#pragma mark --------------- Public Methods

+ (void)removeChildVc:(UIViewController *)childVc {
    [childVc willMoveToParentViewController:nil];
    [childVc.view removeFromSuperview];
    [childVc removeFromParentViewController];
}

// 设置 parentViewController
- (void)setupParentViewController:(UIViewController *)parentViewController {
    self.parentViewController = parentViewController;
}

/** 给外界可以设置ContentOffSet的方法 */
- (void)setContentOffSet:(CGPoint)offset animated:(BOOL)animated {
    self.forbidTouchToAdjustPosition = YES;
    NSInteger currentIndex = offset.x/self.pageCollectionView.bounds.size.width;
    _oldIndex = _currentIndex;
    _currentIndex = currentIndex;
    _scrollOverOnePage = NO;
    
    NSInteger page = labs(_currentIndex - _oldIndex);
    if (page >= 2) {// 需要滚动两页以上的时候, 跳过中间页的动画
        _scrollOverOnePage = YES;
    }
    [self.pageCollectionView setContentOffset:offset animated:animated];
    
}


- (void)reloadData {
    _forbidTouchToAdjustPosition = NO;
    self.childVcsDic = nil;
    if ([self.segmentPageDataSource respondsToSelector:@selector(numberOfChildViewControllers)]) {
        self.childVcCount = [self.segmentPageDataSource numberOfChildViewControllers];
    }
    else {
        NSAssert(NO, @"必须实现的代理方法:numberOfChildViewControllers");
    }
    [self.pageCollectionView reloadData];
    
}

#pragma mark -------------------------- Override Methods
- (void)layoutSubviews {
    [super layoutSubviews];
    self.pageCollectionView.frame = self.bounds;
    self.pageFlowLayout.itemSize = self.frame.size;
}


#pragma mark -------------------------- System Delegate

/***************************** UICollectionViewDataSource *************************/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childVcCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    // 移除subviews 避免重用内容显示错误
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self setupChildVcForCell:cell atIndexPath:indexPath];
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self setupChildVcForCell:cell atIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    if (!self.forbidTouchToAdjustPosition) {
        if (_currentIndex == indexPath.row) {// 没有滚动完成
            if (_needManageLifeCycle) {
                UIViewController<FJSegmentPageChildVcDelegate> *currentVc = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)_oldIndex]];
                // 开始出现
                [currentVc beginAppearanceTransition:YES animated:NO];
                
                UIViewController<FJSegmentPageChildVcDelegate> *oldVc = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
                // 开始消失
                [oldVc beginAppearanceTransition:NO animated:NO];
                
            }
            
            [self didAppearWithIndex:_oldIndex];
            [self didDisappearWithIndex:indexPath.row];
        }
        else {
            
            
            if (_oldIndex == indexPath.row) {
                // 滚动完成
                [self didAppearWithIndex:_currentIndex];
                [self didDisappearWithIndex:indexPath.row];
                
            }
            else {
                // 滚动没有完成又快速的反向打开了另一页
                if (_needManageLifeCycle) {
                    UIViewController<FJSegmentPageChildVcDelegate> *currentVc = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)_oldIndex]];
                    // 开始出现
                    [currentVc beginAppearanceTransition:YES animated:NO];
                    
                    UIViewController<FJSegmentPageChildVcDelegate> *oldVc = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
                    // 开始消失
                    [oldVc beginAppearanceTransition:NO animated:NO];
                    // 消失
                }
                [self didAppearWithIndex:_oldIndex];
                [self didDisappearWithIndex:indexPath.row];
            }
        }
        
    }
    else {
        
        if (_scrollOverOnePage) {
            if (labs(_currentIndex-indexPath.row) == 1) { //滚动完成
                [self didAppearWithIndex:_currentIndex];
                [self didDisappearWithIndex:_oldIndex];
            }
            
        }
        else {
            [self didDisappearWithIndex:_oldIndex];
            [self didAppearWithIndex:_currentIndex];
            
        }
        
    }
    
}

/***************************** UIScrollViewDelegate *************************/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _oldOffSetX = scrollView.contentOffset.x;
    self.forbidTouchToAdjustPosition = NO;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.forbidTouchToAdjustPosition || // 点击标题滚动
        scrollView.contentOffset.x <= 0 || // first or last
        scrollView.contentOffset.x >= scrollView.contentSize.width - scrollView.bounds.size.width) {
        return;
    }
    
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    UINavigationController *navi = (UINavigationController *)self.parentViewController.parentViewController;
    if ([navi isKindOfClass:[UINavigationController class]] && navi.interactivePopGestureRecognizer) {
        navi.interactivePopGestureRecognizer.enabled = YES;
    }
}


#pragma mark --------------- Noti Methods
- (void)receiveMemoryWarningHander:(NSNotificationCenter *)noti {
    
    __weak typeof(self) weakSelf = self;
    [_childVcsDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIViewController<FJSegmentPageChildVcDelegate> * _Nonnull childVc, BOOL * _Nonnull stop) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (childVc != strongSelf.currentChildVc) {
                [_childVcsDic removeObjectForKey:key];
                [FJSegmentedPageContentView removeChildVc:childVc];
            }
        }
    }];
    
}

#pragma mark --------------- Private Methods


// 设置 子控件
- (void)setupViewControls {
    [self addSubview:self.pageCollectionView];
    self.parentViewController = [UIViewController fj_currentViewController];
    _needManageLifeCycle = [self.parentViewController shouldAutomaticallyForwardAppearanceMethods];
    if (!_needManageLifeCycle) {
#if DEBUG
        NSLog(@"\n请注意: 如果你希望所有的子控制器的view的系统生命周期方法被正确的调用\n请重写%@的'shouldAutomaticallyForwardAppearanceMethods'方法 并且返回NO\n当然如果你不做这个操作, 子控制器的生命周期方法将不会被正确的调用\n如果你仍然想利用子控制器的生命周期方法, 请使用'FJSegmentPageChildVcDelegate'提供的代理方法\n或者'FJSegmentPageViewDelegate'提供的代理方法", [self.parentViewController class]);
#endif
    }
}

// 设置 默认 值
- (void)setupDefaultValues {
    _oldIndex = -1;
    _currentIndex = 0;
    _oldOffSetX = 0.0f;
    _forbidTouchToAdjustPosition = NO;
}


- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMemoryWarningHander:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

// 处理当前子控制器的生命周期 : 已知问题, 当push的时候会被调用两次
- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (newWindow == nil) {
        [self willDisappearWithIndex:_currentIndex];
    }
    else {
        [self willAppearWithIndex:_currentIndex];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window == nil) {
        [self didDisappearWithIndex:_currentIndex];
    }
    else {
        [self didAppearWithIndex:_currentIndex];
    }
}


- (void)willAppearWithIndex:(NSInteger)index {
    UIViewController<FJSegmentPageChildVcDelegate> *controller = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)index]];
    if (controller) {
        if ([controller respondsToSelector:@selector(fj_viewWillAppearWithIndex:)]) {
            [controller fj_viewWillAppearWithIndex:index];
        }
        if (_needManageLifeCycle) {
            [controller beginAppearanceTransition:YES animated:NO];
        }
        
        if (_segmentPagedelegate && [_segmentPagedelegate respondsToSelector:@selector(scrollPageController:childViewControllWillAppear:withIndex:)]) {
            [_segmentPagedelegate scrollPageController:self.parentViewController childViewControllWillAppear:controller withIndex:index];
        }
    }
    
    
}

- (void)didAppearWithIndex:(NSInteger)index {
    UIViewController<FJSegmentPageChildVcDelegate> *controller = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)index]];
    if (controller) {
        if ([controller respondsToSelector:@selector(fj_viewDidAppearWithIndex:)]) {
            [controller fj_viewDidAppearWithIndex:index];
        }
        if (_needManageLifeCycle) {
            [controller endAppearanceTransition];
            
        }
        
        if (_segmentPagedelegate && [_segmentPagedelegate respondsToSelector:@selector(scrollPageController:childViewControllDidAppear:withIndex:)]) {
            [_segmentPagedelegate scrollPageController:self.parentViewController childViewControllDidAppear:controller withIndex:index];
        }
    }
    
    
    
}

- (void)willDisappearWithIndex:(NSInteger)index {
    UIViewController<FJSegmentPageChildVcDelegate> *controller = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)index]];
    if (controller) {
        if ([controller respondsToSelector:@selector(fj_viewWillDisappearWithIndex:)]) {
            [controller fj_viewWillDisappearWithIndex:index];
        }
        if (_needManageLifeCycle) {
            [controller beginAppearanceTransition:NO animated:NO];
            
        }
        
        if (_segmentPagedelegate && [_segmentPagedelegate respondsToSelector:@selector(scrollPageController:childViewControllWillDisappear:withIndex:)]) {
            [_segmentPagedelegate scrollPageController:self.parentViewController childViewControllWillDisappear:controller withIndex:index];
        }
    }
    
}
- (void)didDisappearWithIndex:(NSInteger)index {
    UIViewController<FJSegmentPageChildVcDelegate> *controller = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)index]];
    if (controller) {
        if ([controller respondsToSelector:@selector(fj_viewDidDisappearWithIndex:)]) {
            [controller fj_viewDidDisappearWithIndex:index];
        }
        if (_needManageLifeCycle) {
            [controller endAppearanceTransition];
            
        }
        if (_segmentPagedelegate && [_segmentPagedelegate respondsToSelector:@selector(scrollPageController:childViewControllDidDisappear:withIndex:)]) {
            [_segmentPagedelegate scrollPageController:self.parentViewController childViewControllDidDisappear:controller withIndex:index];
        }
    }
}

- (void)setupChildVcForCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (_currentIndex != indexPath.row) {
        return; // 跳过中间的多页
    }
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256.0f)/256.0 green:arc4random_uniform(256.0f)/256.0 blue:arc4random_uniform(256.0f)/256.0 alpha:1.0f];
    _currentChildVc = [self.childVcsDic valueForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    BOOL isFirstLoaded = _currentChildVc == nil;
    
    if (_segmentPageDataSource && [_segmentPageDataSource respondsToSelector:@selector(childViewController:withIndex:)]) {
        if (_currentChildVc == nil) {
            _currentChildVc = [_segmentPageDataSource childViewController:nil withIndex:indexPath.row];
            
            if (!_currentChildVc || ![_currentChildVc conformsToProtocol:@protocol(FJSegmentPageChildVcDelegate)]) {
                NSAssert(NO, @"子控制器必须遵守ZJScrollPageViewChildVcDelegate协议");
            }
            // 设置当前下标
            _currentChildVc.fj_currentIndex = indexPath.row;
            [self.childVcsDic setValue:_currentChildVc forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        } else {
            [_segmentPageDataSource childViewController:_currentChildVc withIndex:indexPath.row];
        }
    } else {
        NSAssert(NO, @"必须设置代理和实现代理方法");
    }
    // 这里建立子控制器和父控制器的关系
    if ([_currentChildVc isKindOfClass:[UINavigationController class]]) {
        NSAssert(NO, @"不要添加UINavigationController包装后的子控制器");
    }
    if ([self fj_scrollViewController:_currentChildVc] != self.parentViewController) {
        [self.parentViewController addChildViewController:_currentChildVc];
    }
    _currentChildVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:_currentChildVc.view];
    [_currentChildVc didMoveToParentViewController:self.parentViewController];
    
    //    NSLog(@"当前的index:%ld", indexPath.row);
    
    if (_isLoadFirstView) { // 第一次加载cell? 不会调用endDisplayCell
        [self willAppearWithIndex:indexPath.row];
        if (isFirstLoaded) {
            // viewDidLoad
            if ([_currentChildVc respondsToSelector:@selector(fj_viewDidLoadWithIndex:)]) {
                [_currentChildVc fj_viewDidLoadWithIndex:indexPath.row];
            }
        }
        [self didAppearWithIndex:indexPath.row];
        
        _isLoadFirstView = NO;
    }
    else {
        
        [self willAppearWithIndex:indexPath.row];
        if (isFirstLoaded) {
            // viewDidLoad
            if ([_currentChildVc respondsToSelector:@selector(fj_viewDidLoadWithIndex:)]) {
                [_currentChildVc fj_viewDidLoadWithIndex:indexPath.row];
            }
        }
        [self willDisappearWithIndex:_oldIndex];
        
    }
}

- (UIViewController *)fj_scrollViewController:(UIViewController *)viewController {
    UIViewController *controller = viewController;
    while (controller) {
        if ([controller conformsToProtocol:@protocol(FJSegmentPageChildVcDelegate)]) {
            break;
        }
        controller = controller.parentViewController;
    }
    return controller;
}

// 设置 选中 索引
- (void)setupSelectedIndex:(NSInteger )selectedIndex animated:(BOOL)animated {
    self.selectedIndex = selectedIndex;
    if (CGSizeEqualToSize(self.pageCollectionView.contentSize, CGSizeZero)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.pageCollectionView.contentSize.width > 0) {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForItem:_selectedIndex inSection:0];
                [self.pageCollectionView selectItemAtIndexPath:tmpIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
            }
        });
    }
    else {
        if (self.pageCollectionView.contentSize.width > _selectedIndex * _pageFlowLayout.itemSize.width) {
            [self.pageCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:animated scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        }
    }
}

#pragma mark --------------- Getter / Setter

// 设置 选中 索引
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _oldIndex = _selectedIndex;
    _selectedIndex = selectedIndex;
    _currentIndex = selectedIndex;
}

- (void)setSegmentViewStyle:(FJSegmentViewStyle *)segmentViewStyle {
    _segmentViewStyle = segmentViewStyle;
}

- (void)setSegmentPageDataSource:(id<FJSegmentPageViewDataSource>)segmentPageDataSource {
    _segmentPageDataSource = segmentPageDataSource;
    if (_segmentPageDataSource) {
        [self reloadData];
    }
}

- (NSMutableDictionary<NSString *,UIViewController<FJSegmentPageChildVcDelegate> *> *)childVcsDic {
    if (!_childVcsDic) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        _childVcsDic = dic;
    }
    return _childVcsDic;
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
        [_pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
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
