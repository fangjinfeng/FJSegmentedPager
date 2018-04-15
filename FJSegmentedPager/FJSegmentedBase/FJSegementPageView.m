
//
//  FJSegementContentView.m
//  FJSegementContentViewDemo
//
//  Created by fjf on 2017/6/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

// tool
#import "FJSegmentViewStyle.h"
// view
#import "FJSegementPageView.h"
#import "FJSegmentedTagTitleView.h"
#import "FJSegmentedPageContentView.h"


// tagSection height
static CGFloat kFJTitleTagSectionViewHeight = 50.0f;

@interface FJSegementPageView()<FJTitleTagSectionViewDelegate,FJDetailContentViewDelegate>


// parentViewController
@property (weak, nonatomic) UIViewController *parentViewController;

// tag sectionView
@property (nonatomic, strong) FJSegmentedTagTitleView *tagSecionView;

// detail contentView
@property (nonatomic, strong) FJSegmentedPageContentView *detailContentView;

@end
@implementation FJSegementPageView

#pragma mark --- custom delegate

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
    }
    return self;
}


#pragma mark --- public method
- (void)reloadData {
    [self.tagSecionView reloadData];
    [self.detailContentView reloadData];
}

#pragma mark --- privete method

- (void)setupViewControls {
    [self addSubview:self.tagSecionView];
    [self addSubview:self.detailContentView];
}

#pragma mark --- custom delegate

/******************************* FJTitleTagSectionViewDelegate ******************************/
// 当前 点击 index
- (void)titleSectionView:(FJSegmentedTagTitleView *)titleSectionView clickIndex:(NSInteger)index {
    
    self.detailContentView.selectedIndex = index;
}

/******************************* FJDetailContentViewDelegate ******************************/
- (void)detailContentView:(FJSegmentedPageContentView *)detailContentView currentIndex:(NSInteger)currentIndex {
    [self.tagSecionView updateControlsStatusWithCurrentIndex:currentIndex];
}

- (void)detailContentView:(FJSegmentedPageContentView *)detailContentView previousIndex:(NSInteger)previousIndex currentIndex:(NSInteger)currentIndex progress:(CGFloat)progress {
    [self.tagSecionView updateControlsWithPreviousIndex:previousIndex currentIndex:currentIndex progress:progress];
}

#pragma mark --- setter method


/** 给外界设置选中的下标的方法 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    self.tagSecionView.selectedIndex = selectedIndex;
    self.detailContentView.selectedIndex = selectedIndex;
}


// 配置 属性
- (void)setSegmentViewStyle:(FJSegmentViewStyle *)segmentViewStyle {
    _segmentViewStyle = segmentViewStyle;
    if (_segmentViewStyle) {
        
        _tagSecionView.segmentViewStyle = segmentViewStyle;
        _detailContentView.segmentViewStyle = segmentViewStyle;
        [self setSelectedIndex:segmentViewStyle.selectedIndex animated:NO];

        
        CGRect detailContentViewFrame = self.detailContentView.frame;
        detailContentViewFrame.origin.y = CGRectGetMaxY(self.tagSecionView.frame);
        detailContentViewFrame.size.height = self.frame.size.height - segmentViewStyle.tagSectionViewHeight;
        self.detailContentView.frame = detailContentViewFrame;

        
        NSAssert(_segmentViewStyle, @"segmentViewStyle  must be passed in before configModelArray");
    }
}

#pragma mark --- getter method

- (void)setDataSource:(id<FJSegmentPageViewDataSource>)dataSource {
    _dataSource = dataSource;
    if (dataSource) {
        self.tagSecionView.segmentPageDataSource = dataSource;
        self.detailContentView.segmentPageDataSource = dataSource;
    }
}

- (void)setDelegate:(id<FJSegmentPageViewDelegate>)delegate {
    _delegate = delegate;
    if (delegate) {
        self.detailContentView.segmentPagedelegate = delegate;
    }
}

// tag sectionView
- (FJSegmentedTagTitleView *)tagSecionView {
    if (!_tagSecionView) {
        _tagSecionView = [[FJSegmentedTagTitleView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kFJTitleTagSectionViewHeight)];
        _tagSecionView.delegate = self;
    }
    return _tagSecionView;
}

// detail contentView
- (FJSegmentedPageContentView *)detailContentView {
    if (!_detailContentView) {
        _detailContentView = [[FJSegmentedPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tagSecionView.frame), self.frame.size.width, self.frame.size.height - kFJTitleTagSectionViewHeight)];
        _detailContentView.delegate = self;
    }
    return _detailContentView;
}
@end
