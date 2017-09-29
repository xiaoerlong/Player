//
//  XEL_ControlView.m
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/28.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_ControlView.h"
#import "UIView+XEL_Frame.h"

static const CGFloat topHeight = 50;
static const CGFloat bottomHeight = 50;

@interface XEL_ControlView ()
// 顶部的控制视图
@property (nonatomic, strong) UIView *topView;
// 底部的控制视图
@property (nonatomic, strong) UIView *bottomView;
// 顶部返回按钮
@property (nonatomic, strong) UIButton *backButton;
// 顶部标题
@property (nonatomic, strong) UILabel *titleLabel;
// 播放控制按钮
@property (nonatomic, strong) UIButton *playbackButton;
// 锁定屏幕按钮
@property (nonatomic, strong) UIButton *lockButton;
// control view是否正在显示
@property (nonatomic, assign) BOOL controlViewIsShowing;
// 是否锁定屏幕
@property (nonatomic, assign) BOOL lockScreen;
@end

@implementation XEL_ControlView

// 代码初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        
        [self addSubview:self.lockButton];
        
        self.controlViewIsShowing = YES;
        self.lockScreen = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    self.topView.frame = CGRectMake(0, 0, width, topHeight);
    self.backButton.frame = CGRectMake(10, 0, 40, self.topView.xel_height);
    self.titleLabel.frame = CGRectMake(65, 0, self.topView.xel_width - 65 - 65, self.topView.xel_height);
    
    self.bottomView.frame = CGRectMake(0, height - bottomHeight, width, bottomHeight);
    self.playbackButton.frame = CGRectMake(10, 0, 40, self.topView.xel_height);
    
    self.lockButton.frame = CGRectMake(15, 0, 40, 40);
    self.lockButton.xel_centerY = self.center.y;
}

#pragma mark -
#pragma mark Action
// 锁定屏幕 竖屏的情况下不显示锁屏按钮
- (void)lockAction:(UIButton *)btn {
    if (self.lockScreen == NO) {
        [_lockButton setImage:[UIImage imageNamed:[@"XEL_Player.bundle" stringByAppendingPathComponent:@"ZFPlayer_lock-nor"]] forState:UIControlStateNormal];
        NSLog(@"锁定屏幕");
        [self hiddenControlView];
    } else {
        [_lockButton setImage:[UIImage imageNamed:[@"XEL_Player.bundle" stringByAppendingPathComponent:@"ZFPlayer_unlock-nor"]] forState:UIControlStateNormal];
        NSLog(@"解锁屏幕");
        [self showControlView];
    }
    self.lockScreen = !self.lockScreen;
}

// 全屏时候返回
- (void)backAction:(UIButton *)btn {
    NSLog(@"点击按钮返回");
}

// 播放控制
- (void)playbackAction:(UIButton *)btn {
    if (btn.selected) { // 正在播放中
        // 点击按钮暂停
        [self xel_playerPlayBackButtonState:NO];
    } else {
        // 点击按钮播放
        [self xel_playerPlayBackButtonState:YES];
    }
}

#pragma mark -
#pragma mark Private
//
- (void)xel_showOrHiddenControlView {
    if (self.controlViewIsShowing == YES) {
        [self hiddenControlView];
    } else {
        [self showControlView];
    }
}
// 隐藏control view
- (void)hiddenControlView {
    [UIView animateWithDuration:0.35 animations:^{
        self.topView.alpha = 0;
        self.bottomView.alpha = 0;
        self.lockButton.alpha = 0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        self.controlViewIsShowing = NO;
    }];
}

// 显示control view
- (void)showControlView {
    [UIView animateWithDuration:0.35 animations:^{
        self.topView.alpha = 1;
        self.bottomView.alpha = 1;
        self.lockButton.alpha = 1;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    } completion:^(BOOL finished) {
        self.controlViewIsShowing = YES;
    }];
}

- (void)xel_playerPlayBackButtonState:(BOOL)isPlay {
    self.playbackButton.selected = isPlay;
}

#pragma mark -
#pragma mark Setter
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark -
#pragma mark Getter

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor clearColor];
        
        // 返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:[@"XEL_Player.bundle" stringByAppendingPathComponent:@"ZFPlayer_back_full"]] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:backButton];
        _backButton = backButton;
        // 视频标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        [_topView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
        
        // 播放控制按钮 播放/暂停
        _playbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playbackButton setImage:[UIImage imageNamed:[@"XEL_Player.bundle" stringByAppendingPathComponent:@"ZFPlayer_play"]] forState:UIControlStateNormal];
        [_playbackButton setImage:[UIImage imageNamed:[@"XEL_Player.bundle" stringByAppendingPathComponent:@"ZFPlayer_pause"]] forState:UIControlStateSelected];
        [_playbackButton addTarget:self action:@selector(playbackAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_playbackButton];
    }
    return _bottomView;
}

- (UIButton *)lockButton {
    if (!_lockButton) {
        _lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockButton setImage:[UIImage imageNamed:[@"XEL_Player.bundle" stringByAppendingPathComponent:@"ZFPlayer_unlock-nor"]] forState:UIControlStateNormal];
        [_lockButton addTarget:self action:@selector(lockAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lockButton;
}

@end
