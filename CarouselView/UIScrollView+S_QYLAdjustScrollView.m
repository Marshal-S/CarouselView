//
//  UIScrollView+S_QYLAdjustScrollView.m
//  PersonBike
//
//  Created by Marshal on 2017/11/11.
//  Copyright © 2017年 Marshal. All rights reserved.
//

#import "UIScrollView+S_QYLAdjustScrollView.h"

@implementation UIScrollView (S_QYLAdjustScrollView)

- (instancetype)adjustScrollView {
    if (@available(iOS 11.0, *)) {
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return self;
}

@end
