//
//  UIView+XEL_Frame.m
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/29.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "UIView+XEL_Frame.h"

@implementation UIView (XEL_Frame)
- (void)setXel_centerY:(CGFloat)xel_centerY {
    CGPoint center = self.center;
    center.y = xel_centerY;
    self.center = center;
}

- (CGFloat)xel_centerY {
    return self.center.y;
}
@end
