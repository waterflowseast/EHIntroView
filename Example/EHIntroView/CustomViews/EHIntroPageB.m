//
//  EHIntroPageB.m
//  EHIntroView
//
//  Created by Eric Huang on 17/1/11.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHIntroPageB.h"
#import <Masonry/Masonry.h>

@interface EHIntroPageB ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation EHIntroPageB

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0 alpha:1.0];
        
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15.0f);
            make.bottom.equalTo(self).offset(-45.0f);
            make.size.mas_equalTo(CGSizeMake(200, 36));
        }];
    }
    
    return self;
}

#pragma mark - getters & setters

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor whiteColor];
        
        [_button setTitle:@"< Dismiss To Left" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _button.clipsToBounds = YES;
        _button.layer.borderWidth = 2.0f;
        _button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _button.layer.cornerRadius = 5.0f;
    }
    
    return _button;
}

@end
