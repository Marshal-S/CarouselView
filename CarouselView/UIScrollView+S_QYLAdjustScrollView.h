//
//  UIScrollView+S_QYLAdjustScrollView.h
//  PersonBike
//
//  Created by Marshal on 2017/11/11.
//  Copyright © 2017年 Marshal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (S_QYLAdjustScrollView)

//isadjust指的是是否自动调整布局
- (instancetype)adjustScrollView:(BOOL)isAdjust viewController:(UIViewController *)vc;

@end
