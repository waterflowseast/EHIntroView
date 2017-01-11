//
//  EHIntroPageA.m
//  EHIntroView
//
//  Created by Eric Huang on 17/1/11.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHIntroPageA.h"
#import <Masonry/Masonry.h>

@interface EHIntroPageA ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation EHIntroPageA

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:90/255.0 green:200/255.0 blue:250/255.0 alpha:1.0];
        
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(180, 180));
        }];
    }
    
    return self;
}

#pragma mark - getters & setters

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor whiteColor];
        
        [_button setTitle:@"Dismiss To Top" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _button.clipsToBounds = YES;
        _button.layer.borderWidth = 5.0f;
        _button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _button.layer.cornerRadius = 90.0f;
    }
    
    return _button;
}

@end
