//
//  XEL_PlayerView.h
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/28.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 视频的播放状态
typedef NS_ENUM(NSUInteger, XELPlayerState) {
    XELPlayerStateFailed,       // 播放失败
    XELPlayerStateBuffering,    // 缓冲
    XELPlayerStatePlay,         // 播放
    XELPlayerStatePause,        // 暂停
    XELPlayerStateStop          // 停止播放
};

/// 视频填充模式
typedef NS_ENUM(NSUInteger, XELPlayerLayerGravity) {
    XELPlayerLayerGravityResize,            // 非均匀模式，两个维度完全填充至整个视图区域
    XELPlayerLayerGravityResizeAspect,      // 等比例填充，直到一个维度到达区域边界
    XELPlayerLayerGravityResizeAspectFill   // 等比例填充，直到填充整个视图区域，其中一个维度的部分区域会被裁剪
};

@interface XEL_PlayerView : UIView

/// 视频播放地址
@property (nonatomic, copy) NSURL *URL;
/// 填充模式
@property (nonatomic, assign) XELPlayerLayerGravity playerLayerGravity;

@end
