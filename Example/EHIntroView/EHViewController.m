//
//  EHViewController.m
//  EHIntroView
//
//  Created by Eric Huang on 01/08/2017.
//  Copyright (c) 2017 Eric Huang. All rights reserved.
//

#import "EHViewController.h"
#import <Masonry/Masonry.h>
#import <EHIntroView/EHIntroView.h>
#import "EHIntroPageA.h"
#import "EHIntroPageB.h"
#import "EHIntroPageC.h"

@interface EHViewController () <EHIntroViewDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) EHIntroView *introView;

@end

@implementation EHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureForNavigationBar];
    [self configureForViews];
}

#pragma mark - EHIntroViewDelegate

- (void)didScrollToPageAtIndex:(NSInteger)index inView:(EHIntroView *)view {
    NSLog(@"==> didScrollToPageAtIndex: %ld", (long)index);
}

- (void)didTapControl:(UIControl *)control inIntroPage:(EHIntroPage *)introPage inIntroView:(EHIntroView *)introView {
    if (introPage.tag == 0) {
        self.introView.dismissDirection = EHIntroViewDismissDirectionTop;
        [self.introView dismissFromSuperview];
        return;
    }
    
    if (introPage.tag == 1) {
        self.introView.dismissDirection = EHIntroViewDismissDirectionLeft;
        [self.introView dismissFromSuperview];
        return;
    }
    
    // when tag is 2
    self.introView.dismissDirection = control.tag;
    [self.introView dismissFromSuperview];
}

#pragma mark - event response

- (void)buttonPressed {
    [self.introView showInView:self.navigationController.view];
}

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"Home";
}

- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100.0f);
        make.width.mas_equalTo(160.0f);
        make.height.mas_equalTo(30.0f);
    }];
}

#pragma mark - getters & setters

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor whiteColor];
        
        [_button setTitle:@"Show IntroView" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _button.clipsToBounds = YES;
        _button.layer.borderWidth = 1.0f;
        _button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _button.layer.cornerRadius = 15.0f;
        
        [_button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (EHIntroView *)introView {
    if (!_introView) {
        NSArray *pages = @[
                           [[EHIntroPageA alloc] init],
                           [[EHIntroPageB alloc] init],
                           [[EHIntroPageC alloc] init]
                           ];
        _introView = [[EHIntroView alloc] initWithIntroPages:pages pageSize:[UIScreen mainScreen].bounds.size];
        _introView.hidesPageControlOnLastPage = YES;
        _introView.delegate = self;
    }
    
    return _introView;
}

@end
