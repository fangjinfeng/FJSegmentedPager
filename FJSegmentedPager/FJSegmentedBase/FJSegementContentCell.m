

//
//  FJSegementContentCell.m
//  FJsegementPageViewDemo
//
//  Created by fjf on 2017/6/16.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJSegmentViewStyle.h"
#import "FJSegementContentCell.h"

@interface FJSegementContentCell()


@end

@implementation FJSegementContentCell

#pragma mark --------------- Life Circle
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellId = NSStringFromClass([FJSegementContentCell class]);
    FJSegementContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[FJSegementContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupControls];
    }
    return self;
}


#pragma mark --------------- Custom Delegate


#pragma mark --------------- Private Methods
// 设置 
- (void)setupControls {
    [self.contentView addSubview:self.segementPageView];
}

#pragma mark --- setter method

// 配置 属性
- (void)setSegmentViewStyle:(FJSegmentViewStyle *)segmentViewStyle {
    _segmentViewStyle = segmentViewStyle;
    if (_segmentViewStyle) {
        _segementPageView.segmentViewStyle = _segmentViewStyle;
    }
}

#pragma mark --------------- Getter / Setter
// 滚动 栏
- (FJSegementPageView *)segementPageView {
    if (!_segementPageView) {
        _segementPageView = [[FJSegementPageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _segementPageView;
}
@end
