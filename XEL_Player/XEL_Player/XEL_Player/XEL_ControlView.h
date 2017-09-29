//
//  XEL_ControlView.h
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/28.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XEL_ControlView : UIView
/// 视频标题
@property (nonatomic, copy) NSString *title;
/// 显示或隐藏控制层
- (void)showOrHiddenControlView;
@end
