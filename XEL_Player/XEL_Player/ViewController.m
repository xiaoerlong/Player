//
//  ViewController.m
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/28.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "ViewController.h"
#import "XEL_PlayerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    XEL_PlayerView *playerView = [[XEL_PlayerView alloc] init];
    playerView.frame = CGRectMake(0, 20, width, 200);
    playerView.URL = [NSURL URLWithString:@"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4"];
    playerView.title = @"网络视频";
    [self.view addSubview:playerView];
    
    XEL_PlayerView *localPlayerView = [[XEL_PlayerView alloc] init];
    localPlayerView.frame = CGRectMake(0, 250, width, 200);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"login_video" ofType:@"mp4"];
    localPlayerView.URL = [NSURL fileURLWithPath:filePath];
    localPlayerView.title = @"本地视频";
    [self.view addSubview:localPlayerView];
}

@end
