
//
//  FJSegementContentView.m
//  FJSegementContentViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJConfigModel.h"
#import "FJSegmentedPageContentView.h"
#import "FJSegementContentView.h"
#import "FJSegmentedTagTitleView.h"

// tagSection height
static CGFloat kFJTitleTagSectionViewHeight = 50.0f;

@interface FJSegementContentView()<FJTitleTagSectionViewDelegate,FJDetailContentViewDelegate>

// tag sectionView
@property (nonatomic, strong) FJSegmentedTagTitleView *tagSecionView;

// detail contentView
@property (nonatomic, strong) FJSegmentedPageContentView *detailContentView;

@end
@implementation FJSegementContentView

#pragma mark --- custom delegate

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setDefaultValues];
        [self addSubview:self.tagSecionView];
        [self addSubview:self.detailContentView];
    }
    return self;
}

#pragma mark --- public method
// 获取 view controller array 
- (NSMutableArray *)getViewControllerArray {
    return self.detailContentView.viewControllerArray;
}

#pragma mark --- privete method

// 设置 默认值
- (void)setDefaultValues {
    self.tagSectionViewHeight = kFJTitleTagSectionViewHeight;
}

// 设置 子控件 数据源
- (void)setupControlsDataArray:(NSArray *)configModelArray {

    NSMutableArray *tmpTitleArray = [NSMutableArray array];
    [_configModelArray enumerateObjectsUsingBlock:^(FJConfigModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tmpTitleArray addObject:[obj.titleStr copy]];
    }];
    self.tagSecionView.tagTitleArray = tmpTitleArray;
    self.detailContentView.detailContentViewArray = configModelArray;
}


#pragma mark --- custom delegate

/******************************* FJTitleTagSectionViewDelegate ******************************/
// 当前 点击 index
- (void)titleSectionView:(FJSegmentedTagTitleView *)titleSectionView clickIndex:(NSInteger)index {
    
    self.detailContentView.selectedIndex = index;
}

/******************************* FJDetailContentViewDelegate ******************************/
- (void)detailContentView:(FJSegmentedPageContentView *)detailContentView currentIndex:(NSInteger)currentIndex {
    
    self.tagSecionView.selectedIndex = currentIndex;
}


#pragma mark --- setter method
// 设置 模型 值
- (void)setConfigModelArray:(NSArray<FJConfigModel *> *)configModelArray {
    _configModelArray = configModelArray;
    if (_configModelArray.count > 0) {
        [self setupControlsDataArray:_configModelArray];
    }
}
// 设置 tagSectionView 高度
- (void)setTagSectionViewHeight:(CGFloat)tagSectionViewHeight {
    _tagSectionViewHeight = tagSectionViewHeight;
    self.tagSecionView.tagSectionViewHeight = _tagSectionViewHeight;
    CGRect detailContentViewFrame = self.detailContentView.frame;
    detailContentViewFrame.origin.y = CGRectGetMaxY(self.tagSecionView.frame);
    detailContentViewFrame.size.height = self.frame.size.height - self.tagSectionViewHeight;
    self.detailContentView.frame = detailContentViewFrame;
    self.detailContentView.tagSectionViewHeight = _tagSectionViewHeight;
}

// 设置 viewController 参数
- (void)setBaseViewControllerParam:(id)baseViewControllerParam {
    _baseViewControllerParam = baseViewControllerParam;
    self.detailContentView.baseViewControllerParam = baseViewControllerParam;
}


// 设置 选中 索引
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (self.configModelArray.count) {
        self.tagSecionView.selectedIndex = selectedIndex;
        self.detailContentView.selectedIndex = selectedIndex;
    }
}

#pragma mark --- getter method

// tag sectionView
- (FJSegmentedTagTitleView *)tagSecionView {
    if (!_tagSecionView) {
        _tagSecionView = [[FJSegmentedTagTitleView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.tagSectionViewHeight)];
        _tagSecionView.delegate = self;
    }
    return _tagSecionView;
}

// detail contentView
- (FJSegmentedPageContentView *)detailContentView {
    if (!_detailContentView) {
        _detailContentView = [[FJSegmentedPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tagSecionView.frame), self.frame.size.width, self.frame.size.height - self.tagSectionViewHeight)];
        _detailContentView.delegate = self;
        _detailContentView.tagSectionViewHeight = self.tagSectionViewHeight;
    }
    return _detailContentView;
}
@end
