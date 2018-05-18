# FJSegmentedPager


支持页面的上下滚动和左右滑动

# 集成方法

1. 静态：手动将``FJSegmentedPager``文件夹拖入到工程中。
2. 动态：``CocoaPods：pod 'FJSegmentedPager'。

# 效果图


![FJSegmentedPageView](https://github.com/fangjinfeng/FJSegmentedPager/blob/master/FJSegmentedPagerDemo/Snapshots/FJSegmentedPageView.gif)

具体详见简书:[FJSegmentedPager 介绍](http://www.jianshu.com/p/700c3814af74)

# 使用方法

### A. 去掉头部:

**1.  设置`segementPageView`,设置`dataSouce`(备注: 如果有需要也设置`delegate`)**
```
// 滚动 栏
- (FJSegementPageView *)segementPageView {
    if (!_segementPageView) {
        _segementPageView = [[FJSegementPageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height)];
        _segementPageView.segmentViewStyle = self.segmentViewStyle;
        _segementPageView.dataSource = self;
    }
    return _segementPageView;
}
```

**2. 实现`dataSource` 代理**
```
#pragma mark --------------- Custom Delegate
// 子页面 总数
- (NSInteger)numberOfChildViewControllers {
    return self.titleArray.count;
}

// 子页面 标题
- (NSArray<NSString *> *)titlesArrayOfChildViewControllers {
    return self.titleArray;
}

/** 获取到将要显示的页面的控制器
 * reuseViewController : 这个是返回给你的controller, 你应该首先判断这个是否为nil, 如果为nil 创建对应的控制器并返回, 如果不为nil直接使用并返回
 * index : 对应的下标
 */
- (UIViewController<FJSegmentPageChildVcDelegate> *)childViewController:(UIViewController<FJSegmentPageChildVcDelegate> *)reuseViewController withIndex:(NSInteger)index {
    
    UIViewController<FJSegmentPageChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[FJSecondShopViewController alloc] init];
    }
    return childVc;
}

```
**如图所示:**
![FJSegmentedPageViewNoHeader.gif](https://upload-images.jianshu.io/upload_images/2252551-7e16133facd30030.gif?imageMogr2/auto-orient/strip)


### B.带有头部:
**1. 继承自`FJSegmentedBaseViewController`:**
```
#import "FJSegmentedBaseViewController.h"

@interface FJFirstShopSegmentedViewController : FJSegmentedBaseViewController

@end
```

**2.  设置`FJSegementContentCell`,然后设置`dataSouce`(备注: 如果有需要也设置`delegate`)**

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FJSegementContentCell *segementContentCell = [FJSegementContentCell cellWithTableView:tableView];
    segementContentCell.segmentViewStyle = self.segmentViewStyle;
    segementContentCell.segementPageView.dataSource = self;
    segementContentCell.segementPageView.delegate = self;
    return segementContentCell;
}
```
**3.实现代理方法**
```
#pragma mark --------------- Custom Delegate

#pragma mark ----  FJSegmentPageViewDataSource
// 子页面 总数
- (NSInteger)numberOfChildViewControllers {
    return self.titleArray.count;
}

// 子页面 标题
- (NSArray<NSString *> *)titlesArrayOfChildViewControllers {
    return self.titleArray;
}

/** 获取到将要显示的页面的控制器
 * reuseViewController : 这个是返回给你的controller, 你应该首先判断这个是否为nil, 如果为nil 创建对应的控制器并返回, 如果不为nil直接使用并返回
 * index : 对应的下标
 */
- (UIViewController<FJSegmentPageChildVcDelegate> *)childViewController:(UIViewController<FJSegmentPageChildVcDelegate> *)reuseViewController withIndex:(NSInteger)index {
    UIViewController<FJSegmentPageChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[FJFirstShopViewController alloc] init];
    }
    return childVc;
}

#pragma mark ----  FJSegmentPageViewDelegate
// 子页面 即将 显示
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController withIndex:(NSInteger)index {
    
}

// 子页面 已经 显示
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController withIndex:(NSInteger)index {
    
}

// 子页面 即将 消失
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController withIndex:(NSInteger)index {
    
}

// 子页面 已经 消失
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController withIndex:(NSInteger)index {
    
}
```
**4. 设置偏移距离**
```
self.tableViewOffsetY = [self.tableView rectForSection:0].origin.y + 10;
```
**效果如图所示:**
![FJSegmentedPageView-OneScreen.gif](https://upload-images.jianshu.io/upload_images/2252551-36df1273e2c215f5.gif?imageMogr2/auto-orient/strip)


> **具体操作详见:[Demo](https://github.com/fangjinfeng/FJSegmentedPager)**
# 二. 参数 详解
**1. 通过``FJSegmentViewStyle``来配置相关参数**

```

// 指示器 宽度 显示 类型
typedef NS_ENUM(NSInteger, FJSegmentIndicatorWidthShowType) {
    // 自适应
    FJSegmentIndicatorWidthShowTypeAdaption = 0,
    // 固定 宽度
    FJSegmentIndicatorWidthShowTypeAdaptionFixedWidth,
};


// 标题 view 字体颜色 改变 类型
typedef NS_ENUM(NSInteger, FJSegmentTitleViewTitleColorChangeType) {
    // 选中 之后 再 颜色 改变
    FJSegmentTitleViewTitleColorChangeTypeSelectedChange = 0,
    // 颜色 渐变
    FJSegmentTitleViewTitleColorChangeTypeGradualChange,
};


@interface FJSegmentViewStyle : NSObject
// 选择 第几个 tag
@property (nonatomic, assign) NSInteger selectedIndex;
// 标题 栏 高度
@property (nonatomic, assign) CGFloat tagSectionViewHeight;
// 分割线 高度
@property (nonatomic, assign) CGFloat separatorLineHeight;
// 指示条 高度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewHeight;
// 指示条 宽度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewWidth;
// 指示条 距离 底部 间距
@property (nonatomic, assign) CGFloat segmentedIndicatorViewWidthToBottomSpacing;
// 指示条 默认 扩展宽度
@property (nonatomic, assign) CGFloat segmentedIndicatorViewExtendWidth;
// 标题 默认 宽度
@property (nonatomic, assign) CGFloat segmentedTitleViewTitleWidth;
// 标题栏 cell  间距
@property (nonatomic, assign) CGFloat segmentedTagSectionCellSpacing;
// 标题栏 左右 间距
@property (nonatomic, assign) CGFloat segmentedTagSectionHorizontalEdgeSpacing;
// 标题 字体
@property (nonatomic, strong) UIFont *itemTitleFont;
// 标题 选中 字体
@property (nonatomic, strong) UIFont *itemTitleSelectedFont;
// 标题 分隔栏 背景色
@property (nonatomic, strong) UIColor *segmentToolbackgroundColor;
// 分段 标题 字体 普通 颜色
@property (nonatomic, strong) UIColor *itemTitleColorStateNormal;
// 分段 标题 字体 选中 颜色
@property (nonatomic, strong) UIColor *itemTitleColorStateSelected;
// 分段 标题 字体 高亮 颜色
@property (nonatomic, strong) UIColor *itemTitleColorStateHighlighted;
// 分割线 背景色
@property (nonatomic, strong) UIColor *separatorBackgroundColor;
// tableView 背景色
@property (nonatomic, strong) UIColor *tableViewBackgroundColor;
// 指示器 背景色
@property (nonatomic, strong) UIColor *indicatorViewBackgroundColor;
// 指示器 宽度 显示 类型
@property (nonatomic, assign) FJSegmentIndicatorWidthShowType segmentIndicatorWidthShowType;
// 标题 字体 颜色 改变 类型
@property (nonatomic, assign) FJSegmentTitleViewTitleColorChangeType titleColorChangeType;
```

