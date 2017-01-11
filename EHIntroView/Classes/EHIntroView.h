//
//  EHIntroView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/23.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef EHIntroView_H
#define EHIntroView_H

typedef NS_ENUM(NSUInteger, EHIntroViewDismissDirection) {
    EHIntroViewDismissDirectionTop,
    EHIntroViewDismissDirectionLeft
};

#endif

@class EHIntroPage;
@class EHIntroView;

@protocol EHIntroViewDelegate <NSObject>

@optional
- (void)didScrollToPageAtIndex:(NSInteger)index inView:(EHIntroView *)view;
- (void)didTapControl:(UIControl *)control inIntroPage:(EHIntroPage *)introPage inIntroView:(EHIntroView *)introView;

@end

@interface EHIntroView : UIView

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, assign) CGFloat distanceBetweenPageControlAndBottom;
@property (nonatomic, assign) EHIntroViewDismissDirection dismissDirection;
@property (nonatomic, assign) BOOL hidesPageControlOnLastPage;
@property (nonatomic, assign) id<EHIntroViewDelegate> delegate;

- (instancetype)initWithIntroPages:(NSArray <EHIntroPage *> *)introPages pageSize:(CGSize)pageSize;

- (void)showInView:(UIView *)view;
- (void)dismissFromSuperview;

@end
