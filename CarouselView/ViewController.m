//
//  ViewController.m
//  CarouselView
//
//  Created by Marshal on 2017/12/5.
//  Copyright © 2017年 Marshal. All rights reserved.
//

#import "ViewController.h"
#import "QYLCarouselView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)initContentView {
    NSArray *images = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg"];
    QYLCarouselView *carouselView = [[QYLCarouselView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*9/16) images:images];
    [self.view addSubview:carouselView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
