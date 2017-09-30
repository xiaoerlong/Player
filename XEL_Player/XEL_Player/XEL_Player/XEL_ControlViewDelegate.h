//
//  XEL_ControlViewDelegate.h
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/29.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol XEL_ControlViewDelegate <NSObject>
@optional
/// 播放
- (void)controlViewTapPlayAction;
/// 暂停
- (void)controlViewTapPauseAction;
/// 停止
- (void)controlViewTapStopAction;
/// 跳转到指定时间播放
- (void)playForSeekTime:(CGFloat)time;
/// 切换分辨率
- (void)controlViewTapResolutionAction;
@end
