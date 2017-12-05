//
//  UIScrollView+S_QYLAdjustScrollView.m
//  PersonBike
//
//  Created by Marshal on 2017/11/11.
//  Copyright © 2017年 Marshal. All rights reserved.
//

#import "UIScrollView+S_QYLAdjustScrollView.h"

@implementation UIScrollView (S_QYLAdjustScrollView)

- (instancetype)adjustScrollView:(BOOL)isAdjust viewController:(UIViewController *)vc {
    if (@available(iOS 11.0, *)) {
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        if (IS_IPHONEX) {
            self.scrollIndicatorInsets =  UIEdgeInsetsMake(0, 0, 34, 0);//滚动视图的框
        }
    }else {
        if (vc) vc.automaticallyAdjustsScrollViewInsets = isAdjust;
    }
    return self;
}

@end
