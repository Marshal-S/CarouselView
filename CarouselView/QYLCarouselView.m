//
//  QYLCarouselView.m
//  CarouselView
//
//  Created by Marshal on 2017/12/5.
//  Copyright © 2017年 Marshal. All rights reserved.
//

#import "QYLCarouselView.h"
#import "UIScrollView+S_QYLAdjustScrollView.h"

typedef NS_ENUM(NSUInteger, QYLDirectionType) {
    QYLDirectionTypeRight, //右侧方向图片
    QYLDirectionTypeLeft //左侧方向图片
};

@interface QYLCarouselView ()<UIScrollViewDelegate>
{
    NSInteger _totolCount;
    NSInteger _currentIndex;
}

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) UIImageView *middleView;
@property (nonatomic, strong) UIImageView *rightView;

@property (nonatomic, copy) NSArray *images;

@end

@implementation QYLCarouselView

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<NSString *> *)images {
    NSAssert(images && images.count > 0, @"图片数组不能为空");
    if (self = [super initWithFrame:frame]) {
        _images = images;
        _totolCount = images.count;
        [self initContentView];
        [self startTimer];
    }
    return self;
}

- (void)initContentView {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [_scrollView adjustScrollView].showsHorizontalScrollIndicator = NO;
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(3*width, height);
    [_scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    [self addSubview:_scrollView];
    
    _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _leftView.image = [UIImage imageNamed:_images[[self getImageIndex:_currentIndex-1]]];
    [_scrollView addSubview:_leftView];
    
    _middleView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    _middleView.image = [UIImage imageNamed:_images[_currentIndex]];
    [_scrollView addSubview:_middleView];
    
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(width*2, 0, width, height)];
    _rightView.image = [UIImage imageNamed:_images[[self getImageIndex:_currentIndex+1]]];
    [_scrollView addSubview:_rightView];
    
    _leftView.contentMode = _middleView.contentMode = _rightView.contentMode = UIViewContentModeScaleAspectFit;
    
    //初始化指示剂
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(width/2-3*_totolCount, height-20, 6*_totolCount, 6)];
    _pageControl.numberOfPages = _totolCount;
    [self addSubview:_pageControl];
}

- (void)startTimer {
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(startCarousel) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)startCarousel {
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
}

- (void)removeTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark --scrollView停止减速后的回调
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateImageView];
}

#pragma mark --scrollView停止动画的回调，一般为主动设置滚动动画的时候才走
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateImageView];
}

#pragma mark --更新images视图
- (void)updateImageView {
    CGFloat width = self.frame.size.width;
    if (_scrollView.contentOffset.x == 0) {
        //向左显示的
        _currentIndex--;
        [self resetImageView];
    }else if (_scrollView.contentOffset.x == width*2) {
        //向左显示的
        _currentIndex++;
        [self resetImageView];
    }
    //其他的不操作
}

#pragma mark --每滑动一次重置一下图片卡槽
- (void)resetImageView {
    //重置的时候不允许滑动，防止错乱
    _currentIndex = [self getImageIndex:_currentIndex];
    
    _scrollView.scrollEnabled = NO;
    _leftView.image = [UIImage imageNamed:_images[[self getImageIndex:_currentIndex-1]]];
    _middleView.image = [UIImage imageNamed:_images[_currentIndex]];
    _rightView.image = [UIImage imageNamed:_images[[self getImageIndex:_currentIndex+1]]];
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:NO];
    _scrollView.scrollEnabled = YES;
    
    _pageControl.currentPage = _currentIndex;
}

#pragma mark --注意这个方法will添加的时候走一次，要被销毁的时候也要走一次
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    //在其要被销毁的时候
    if (!newSuperview) {
        [self removeTimer];
    }
}

#pragma mark --处理索引值
- (NSInteger)getImageIndex:(NSInteger)index {
    return (index+_totolCount)%_totolCount;
}

- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
}

- (void)dealloc {
    NSLog(@"我要被销毁了");
}

@end
