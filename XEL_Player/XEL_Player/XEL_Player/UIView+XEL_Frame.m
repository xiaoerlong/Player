//
//  UIView+XEL_Frame.m
//  XEL_Player
//
//  Created by Tronsis－mac on 17/9/29.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "UIView+XEL_Frame.h"

@implementation UIView (XEL_Frame)
- (void)setXel_x:(CGFloat)xel_x {
    CGRect frame = self.frame;
    frame.origin.x = xel_x;
    self.frame = frame;
}

- (CGFloat)xel_x {
    return self.frame.origin.x;
}

- (void)setXel_width:(CGFloat)xel_width {
    CGRect frame = self.frame;
    frame.size.width = xel_width;
    self.frame = frame;
}

- (CGFloat)xel_width {
    return self.frame.size.width;
}

- (void)setXel_height:(CGFloat)xel_height {
    CGRect frame = self.frame;
    frame.size.height = xel_height;
    self.frame = frame;
}

- (CGFloat)xel_height {
    return self.frame.size.height;
}

- (void)setXel_centerY:(CGFloat)xel_centerY {
    CGPoint center = self.center;
    center.y = xel_centerY;
    self.center = center;
}

- (CGFloat)xel_centerY {
    return self.center.y;
}
@end
