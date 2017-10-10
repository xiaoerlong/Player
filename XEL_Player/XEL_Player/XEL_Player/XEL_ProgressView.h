//
//  XEL_ProgressView.h
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/30.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

// 进度条自定义视图

#import <UIKit/UIKit.h>

@interface XEL_ProgressView : UIView
// 设置缓冲
- (void)setBuffer:(CGFloat)buffer;
// 设置视频总时长
- (void)setVideoTotalTime:(NSTimeInterval)totalTime;
// 更新播放进度
- (void)updatePlayProgress:(NSTimeInterval)current total:(NSTimeInterval)total;
// 跳转到指定时间播放
@property (nonatomic, copy) void(^ SliderHandle)(CGFloat value);
@end
