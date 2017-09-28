//
//  XEL_ControlView.m
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/28.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_ControlView.h"

static const CGFloat topHeight = 50;
static const CGFloat bottomHeight = 50;

@interface XEL_ControlView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation XEL_ControlView

// 代码初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    self.topView.frame = CGRectMake(0, 0, width, topHeight);
    self.bottomView.frame = CGRectMake(0, height - bottomHeight, width, bottomHeight);
}

#pragma mark -
#pragma mark Private

#pragma mark -
#pragma mark Getter

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor redColor];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor greenColor];
    }
    return _bottomView;
}

@end
