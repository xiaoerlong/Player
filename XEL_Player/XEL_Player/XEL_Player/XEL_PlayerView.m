//
//  XEL_PlayerView.m
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/28.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_PlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "XEL_ControlView.h"

@interface XEL_PlayerView () <UIGestureRecognizerDelegate>
//======播放相关组件======
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVURLAsset *urlAsset;
@property (nonatomic, strong) AVAssetImageGenerator *imageGenerator; // 获取视频里面任何一帧的图片
//======end======

// 播放状态相关
@property (nonatomic, assign) XELPlayerState playerState;
// 视频填充模式
@property (nonatomic, strong) NSString *videoGravity;
// 视频控制view
@property (nonatomic, strong) XEL_ControlView *controlView;


// 手势相关
@property (nonatomic, strong) UITapGestureRecognizer *singleTapGesture; // 单击显示控制层
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture; // 双击控制播放暂停
@end

@implementation XEL_PlayerView

// 代码初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

// xib或storyboard初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor blackColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 重新设置playerLayer
    self.playerLayer.frame = self.bounds;
}

- (void)dealloc {
    [self removeObserver];
}

#pragma mark -
#pragma mark KVO
// 添加KVO
- (void)addObserver {
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

// 注销KVO
- (void)removeObserver {
    [_playerItem removeObserver:self forKeyPath:@"status"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerItemStatusUnknown:
                NSLog(@"未知状态");
                break;
            case AVPlayerItemStatusFailed:
                NSLog(@"失败");
                _playerState = XELPlayerStateFailed;
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准备播放");
                /* 重新设置layer的frame */
//                [self setNeedsLayout];
                [self layoutIfNeeded];
                /*========*/
                
                // 添加playerLayer到layer  先调用play方法，再将playerLayer添加到layer中，可以实现播放的时候显示
                [self.layer insertSublayer:self.playerLayer atIndex:0];
                _playerState = XELPlayerStatePlay;
                break;
        }
    }
}


#pragma mark -
#pragma mark Player
// 配置播放相关组件
- (void)configurePlayerComponents {
    
    _urlAsset = [AVURLAsset assetWithURL:_URL];
    _playerItem = [AVPlayerItem playerItemWithAsset:_urlAsset];
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.videoGravity = self.videoGravity;
    
    if ([_URL.scheme isEqualToString:@"file"]) {
        // 本地视频
        self.playerState = XELPlayerStatePlay;
    } else {
        // 网络视频
        self.playerState = XELPlayerStateBuffering;
    }
    
    [self play];
    
    [self addObserver];
}

#pragma mark -
#pragma mark Action-播放控制
// 播放
- (void)play {
    if (_playerState == XELPlayerStatePlay) {
        return;
    }
    _playerState = XELPlayerStatePlay;
    [_player play];
}

// 单击
- (void)singleTapAction:(UITapGestureRecognizer *)tapGesture {
    [self showOrHiddenControlView];
}

// 双击
- (void)doubleTapAction:(UITapGestureRecognizer *)tapGesture {
    
}

// 显示或者隐藏控制视图
- (void)showOrHiddenControlView {
    [self.controlView showOrHiddenControlView];
}

#pragma mark -
#pragma mark Private
// 创建手势
- (void)createGesture {
    self.singleTapGesture = ({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        tap;
    });
    self.doubleTapGesture = ({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
        tap.numberOfTapsRequired = 2;
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        tap;
    });
    
    // 双击手势响应如果失败，将双击事件传递给单击手势
    [self.singleTapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
}

#pragma mark -
#pragma mark Setter
- (void)setURL:(NSURL *)URL {
    _URL = URL;
    _controlView = [[XEL_ControlView alloc] initWithFrame:self.bounds];
    [self addSubview:_controlView];
    [self configurePlayerComponents];
    
    // 添加手势
    [self createGesture];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _controlView.title = title;
}

- (void)setPlayerState:(XELPlayerState)playerState {
    _playerState = playerState;
    if (playerState == XELPlayerStateFailed) {
        // 提示播放失败
    } else if (playerState == XELPlayerStateBuffering) {
        // 提示缓冲中，加载进度条
    } else if (playerState == XELPlayerStatePlay) {
        // 播放
        [_player play];
    } else if (playerState == XELPlayerStatePause) {
        // 暂停播放
        [_player pause];
    } else if (playerState == XELPlayerStateStop) {
        // 停止播放
        _player = nil;
    }
}

- (void)setPlayerLayerGravity:(XELPlayerLayerGravity)playerLayerGravity {
    _playerLayerGravity = playerLayerGravity;
    switch (playerLayerGravity) {
        case XELPlayerLayerGravityResize: {
            self.videoGravity = AVLayerVideoGravityResize;
            self.playerLayer.videoGravity = AVLayerVideoGravityResize;
            break;
        }
        case XELPlayerLayerGravityResizeAspect: {
            self.videoGravity = AVLayerVideoGravityResizeAspect;
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            break;
        }
        case XELPlayerLayerGravityResizeAspectFill: {
            self.videoGravity = AVLayerVideoGravityResizeAspectFill;
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            break;
        }
    }
}

#pragma mark -
#pragma mark Getter
- (NSString *)videoGravity {
    if (!_videoGravity) {
        _videoGravity = AVLayerVideoGravityResizeAspect;
    }
    return _videoGravity;
}



- (UITapGestureRecognizer *)doubleTapGesture {
    if (!_doubleTapGesture) {
        _doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
        _doubleTapGesture.numberOfTouchesRequired = 1;
        _doubleTapGesture.numberOfTapsRequired = 2;
    }
    return _doubleTapGesture;
}

@end
