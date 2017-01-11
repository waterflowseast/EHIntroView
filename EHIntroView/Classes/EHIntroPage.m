//
//  EHIntroPage.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/23.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHIntroPage.h"
#import <EHItemViewCommon/UIView+EHItemViewDelegate.h>

@implementation EHIntroPage

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            UIControl *control = (UIControl *)view;
            [control addTarget:self action:@selector(didTapControl:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - event response

- (void)didTapControl:(UIControl *)sender {
    if ([self.eh_itemViewDelegate respondsToSelector:@selector(didTapControl:inView:)]) {
        [self.eh_itemViewDelegate didTapControl:sender inView:self];
    }
}

@end
