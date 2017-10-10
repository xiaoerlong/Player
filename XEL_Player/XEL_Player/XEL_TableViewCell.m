//
//  XEL_TableViewCell.m
//  XEL_Player
//
//  Created by xiaoerlong on 2017/10/7.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_TableViewCell.h"
#import "XEL_PlayerView.h"

@implementation XEL_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    XEL_PlayerView *playerView = [[XEL_PlayerView alloc] init];
    playerView.frame = self.bounds;
    playerView.URL = [NSURL URLWithString:@"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4"];
    playerView.title = @"网络视频";
    [self.playerSuperView addSubview:playerView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
