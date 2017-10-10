//
//  QNPersonalHeaderView.m
//  QNFenXiao
//
//  Created by fjf on 2017/3/15.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "QNPersonalHeaderView.h"


// 按键 扩大 范围
static CGFloat const kQNPersonalHeaderViewButtonTouchExtend = -15.0f;

@interface QNPersonalHeaderView()
// 消息 按键
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
// 播放 按键
@property (weak, nonatomic) IBOutlet UIButton *playingButton;
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
// 会员 等级
@property (weak, nonatomic) IBOutlet UIButton *memberRankButton;
// 跨级 收益
@property (weak, nonatomic) IBOutlet UILabel *strideEarningLabel;
// 跨级 收益 金额
@property (weak, nonatomic) IBOutlet UILabel *strideEarningMoneyLabel;
// 累计 收益
@property (weak, nonatomic) IBOutlet UILabel *accumulativeEarningLabel;
// 累计 收益 金额
@property (weak, nonatomic) IBOutlet UILabel *accumulativeEarningMoneyLabel;
// 竖直 分割线
@property (weak, nonatomic) IBOutlet UIView *verticalSplitLineView;
// 水平 分割线
@property (weak, nonatomic) IBOutlet UIView *horizontalSplitLineView;
// 跨级 收益 view
@property (weak, nonatomic) IBOutlet UIView *strideEarningMoneyView;
// 累计 收益 view
@property (weak, nonatomic) IBOutlet UIView *accumulativeEarningView;
//红点
@property (weak, nonatomic) IBOutlet UIView *redView;
//开通会员按钮
@property (weak, nonatomic) IBOutlet UIButton *openVipButton;
@end

@implementation QNPersonalHeaderView

#pragma mark --- init method

// 创建 headerView
+ (QNPersonalHeaderView *)createView {
    return [[[NSBundle mainBundle] loadNibNamed:@"QNPersonalHeaderView" owner:self options:kNilOptions] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}


@end
