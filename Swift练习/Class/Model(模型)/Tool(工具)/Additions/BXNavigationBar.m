//
//  BXNavigationBar.m
//  Swift练习
//
//  Created by ME294 on 2018/3/25.
//  Copyright © 2018年 EDZ. All rights reserved.
//

#define naviBarHeight CGRectGetHeight(self.frame)

#import "BXNavigationBar.h"

@implementation BXNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //注意导航栏及状态栏高度适配
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), naviBarHeight);
    for (UIView *view in self.subviews) {
        if([NSStringFromClass([view class]) containsString:@"Background"]) {
            view.frame = self.bounds;
        }
        else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
            CGRect frame = view.frame;
            frame.origin.y = naviBarHeight;
            frame.size.height = self.bounds.size.height - frame.origin.y;
            view.frame = frame;
        }
    }
    
}

@end
