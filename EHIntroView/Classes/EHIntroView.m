//
//  EHIntroView.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/23.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHIntroView.h"
#import "EHIntroPage.h"
#import <EHItemViewCommon/UIView+EHItemViewDelegate.h>

@interface EHIntroView () <UIScrollViewDelegate, EHItemViewDelegate>

@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, assign) CGSize pageSize;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSLayoutConstraint *distanceConstraint;

@end

@implementation EHIntroView

- (instancetype)initWithIntroPages:(NSArray<EHIntroPage *> *)introPages pageSize:(CGSize)pageSize {
    self = [super init];
    if (self) {
        _numberOfPages = introPages.count;
        _pageSize = pageSize;

        [self addScrollViewAndPageControl];
        [self addToScrollViewWithIntroPages:introPages];
    }
    
    return self;
}

- (void)showInView:(UIView *)view {
    self.frame = view.bounds;
    [view addSubview:self];
}

- (void)dismissFromSuperview {
    UIView *view = self.superview;

    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = view.bounds;
        
        if (self.dismissDirection == EHIntroViewDismissDirectionLeft) {
            frame.origin.x = - _pageSize.width;
        } else {
            frame.origin.y = - _pageSize.height;
        }

        self.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (!self.hidesPageControlOnLastPage || self.numberOfPages == 1) {
        return;
    }

    NSInteger currentPage = self.pageControl.currentPage;
    NSInteger maxPageIndex = self.numberOfPages - 1;

    if (currentPage == maxPageIndex && velocity.x < 0) {
        self.pageControl.hidden = NO;
    } else if (currentPage + 1 == maxPageIndex && velocity.x > 0) {
        self.pageControl.hidden = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageIndex = (int)floorf(scrollView.contentOffset.x / self.pageSize.width);
    self.pageControl.currentPage = pageIndex;
    
    if ([self.delegate respondsToSelector:@selector(didScrollToPageAtIndex:inView:)]) {
        [self.delegate didScrollToPageAtIndex:pageIndex inView:self];
    }
}

#pragma mark - EHItemViewDelegate

- (void)didTapControl:(UIControl *)control inView:(UIView *)view {
    if ([self.delegate respondsToSelector:@selector(didTapControl:inIntroPage:inIntroView:)]) {
        [self.delegate didTapControl:control inIntroPage:(EHIntroPage *)view inIntroView:self];
    }
}

#pragma mark - private methods

- (void)addScrollViewAndPageControl {
    // add scrollView
    [self addSubview:self.scrollView];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0],
                           [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
                           [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0],
                           [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]
                           ]];
    
    // add pageControl
    [self addSubview:self.pageControl];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.distanceConstraint = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraints:@[self.distanceConstraint,
                           [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]
                           ]];
}

- (void)addToScrollViewWithIntroPages:(NSArray <EHIntroPage *> *)introPages {
    for (int i = 0; i < introPages.count; i++) {
        EHIntroPage *introPage = introPages[i];
        introPage.tag = i;
        introPage.eh_itemViewDelegate = self;
        
        introPage.frame = CGRectMake(i * self.pageSize.width,
                                     0,
                                     self.pageSize.width,
                                     self.pageSize.height);
        [self.scrollView addSubview:introPage];
    }
}

#pragma mark - getters & setters

- (void)setDistanceBetweenPageControlAndBottom:(CGFloat)distanceBetweenPageControlAndBottom {
    _distanceBetweenPageControlAndBottom = distanceBetweenPageControlAndBottom;

    _distanceConstraint.constant = -distanceBetweenPageControlAndBottom;
    [self setNeedsUpdateConstraints];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_numberOfPages * _pageSize.width, _pageSize.height);
        
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.enabled = NO;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.numberOfPages = _numberOfPages;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0f];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0f];
    }
    
    return _pageControl;
}

@end
