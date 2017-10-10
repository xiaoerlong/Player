//
//  XEL_ControlView.h
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/28.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XEL_ControlViewDelegate.h"

@interface XEL_ControlView : UIView
@property (nonatomic, weak) id <XEL_ControlViewDelegate> delegate;
/// 视频标题
@property (nonatomic, copy) NSString *title;
/// 显示或隐藏控制层
- (void)xel_showOrHiddenControlView;
// 播放按钮的状态
- (void)xel_playerPlayBackButtonState:(BOOL)isPlay;
// 视频总时长
- (void)xel_playerTotalTime:(NSTimeInterval)totalTime;
// 设置缓冲进度
- (void)xel_playerBuffer:(NSTimeInterval)totalBuffer playerItemTime:(NSTimeInterval)totalTime;
// 播放进度更新
- (void)xel_playerCurrentPlayTime:(NSTimeInterval)current playerItemTime:(NSTimeInterval)totalTime;
@end
