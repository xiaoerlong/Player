//
//  XEL_ProgressView.m
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/30.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_ProgressView.h"
#import "UIView+XEL_Frame.h"

@interface XEL_ProgressView ()
// 进度条背景
@property (nonatomic, strong) UIView *progressBackgroundView;
// 缓冲进度
@property (nonatomic, strong) UIProgressView *bufferProgressView;
// 播放进度
@property (nonatomic, strong) UISlider *playbackSlider;
// 时间显示
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation XEL_ProgressView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.progressBackgroundView];
        [self addSubview:self.bufferProgressView];
        [self addSubview:self.playbackSlider];
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件之间的边距
    CGFloat itemPadding = 10;
    // 先需要设置timeLabel
    [self.timeLabel sizeToFit];
    self.timeLabel.xel_x = self.xel_width - self.timeLabel.xel_width;
    self.timeLabel.xel_height = self.xel_height;
    
    CGFloat progressWidth = self.xel_width - self.timeLabel.xel_width - itemPadding;
    CGFloat progressHeight = 2;
    self.progressBackgroundView.frame = CGRectMake(0, self.xel_centerY - progressHeight / 2, progressWidth, progressHeight);
    self.bufferProgressView.frame = self.progressBackgroundView.frame;
    self.playbackSlider.frame = CGRectMake(-5, 0, progressWidth + 10, self.xel_height);
}

#pragma mark -
#pragma mark Action
- (void)playbackSliderAction:(UISlider *)slider {
    if (self.SliderHandle) {
        self.SliderHandle(slider.value);
    }
}

#pragma mark -
#pragma mark Public
- (void)setBuffer:(CGFloat)buffer {
    self.bufferProgressView.progress = buffer;
}

- (void)updatePlayProgress:(NSTimeInterval)current total:(NSTimeInterval)total {
    self.playbackSlider.value = current/total;
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", [self transformTime:current], [self transformTime:total]];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setVideoTotalTime:(NSTimeInterval)totalTime {
    self.timeLabel.text = [NSString stringWithFormat:@"00:00/%@", [self transformTime:totalTime]];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark -
#pragma mark Private
// 将秒转为时分秒表示
- (NSString *)transformTime:(NSTimeInterval)time {
    NSInteger second = (NSInteger)time % 60;
    NSInteger minute = (NSInteger)(time / 60);
    NSString *transformTime = nil;
    if (minute > 0) {
        transformTime = [NSString stringWithFormat:@"%.2ld:%.2ld", (long)minute, (long)second];
    } else {
        transformTime = [NSString stringWithFormat:@"00:%.2ld", (long)second];
    }
    return transformTime;
}

#pragma mark -
#pragma mark Getter
- (UIView *)progressBackgroundView {
    if (!_progressBackgroundView) {
        _progressBackgroundView = [[UIView alloc] init];
        _progressBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _progressBackgroundView;
}

- (UIProgressView *)bufferProgressView {
    if (!_bufferProgressView) {
        _bufferProgressView = [[UIProgressView alloc] init];
        _bufferProgressView.backgroundColor = [UIColor clearColor];
        _bufferProgressView.progressTintColor = [UIColor lightGrayColor];
        _bufferProgressView.trackTintColor = [UIColor clearColor];
        _bufferProgressView.progress = 0;
    }
    return _bufferProgressView;
}

- (UISlider *)playbackSlider {
    if (!_playbackSlider) {
        _playbackSlider = [[UISlider alloc] init];
        _playbackSlider.minimumTrackTintColor = [UIColor greenColor];
        _playbackSlider.maximumTrackTintColor = [UIColor clearColor];
        _playbackSlider.thumbTintColor = [UIColor whiteColor];
        _playbackSlider.value = 0;
        _playbackSlider.continuous = NO;
        [_playbackSlider addTarget:self action:@selector(playbackSliderAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _playbackSlider;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.text = @"00:00/00:00";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
}
@end
