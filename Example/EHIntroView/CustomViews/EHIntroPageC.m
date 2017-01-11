//
//  EHIntroPageC.m
//  EHIntroView
//
//  Created by Eric Huang on 17/1/11.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHIntroPageC.h"
#import <Masonry/Masonry.h>

@interface EHIntroPageC ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation EHIntroPageC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:76/255.0 green:217/255.0 blue:100/255.0 alpha:1.0];
        
        [self addSubview:self.leftButton];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10.0f);
            make.bottom.equalTo(self).offset(-100.0f);
            make.size.mas_equalTo(CGSizeMake(165, 30));
        }];
        
        [self addSubview:self.rightButton];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10.0f);
            make.bottom.equalTo(self).offset(-100.0f);
            make.size.mas_equalTo(CGSizeMake(165, 30));
        }];
    }
    
    return self;
}

#pragma mark - getters & setters

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = [UIColor whiteColor];
        
        [_leftButton setTitle:@"Dismiss To Top" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _leftButton.clipsToBounds = YES;
        _leftButton.layer.borderWidth = 1.0f;
        _leftButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _leftButton.layer.cornerRadius = 15.0f;
        
        _leftButton.tag = 0;
    }
    
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor whiteColor];
        
        [_rightButton setTitle:@"< Dismiss To Left" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _rightButton.clipsToBounds = YES;
        _rightButton.layer.borderWidth = 1.0f;
        _rightButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _rightButton.layer.cornerRadius = 15.0f;
        
        _rightButton.tag = 1;
    }
    
    return _rightButton;
}

@end
