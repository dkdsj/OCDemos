//
//  GuideView.m
//  GuideDemo
//
//  Created by 李剑钊 on 15/7/23.
//  Copyright (c) 2015年 sunli. All rights reserved.
//  https://github.com/sunljz/demo

#import "GuideView.h"
#import "UIView+Layout.h"
#import "UIImage+Mask.h"

@interface GuideView ()

@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, strong) UIView *maskBg;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIImageView *btnMaskView;
@property (nonatomic, strong) UIImageView *arrwoView;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, weak) UIView *maskTarget;

@property (nonatomic, strong) UIView *topMaskView;
@property (nonatomic, strong) UIView *bottomMaskView;
@property (nonatomic, strong) UIView *leftMaskView;
@property (nonatomic, strong) UIView *rightMaskView;

@property (nonatomic, assign) NSInteger currentIndex;//当前指引视图
@property (nonatomic, strong) NSArray<UIView *> *targetViews;
@property (nonatomic, copy) void (^tapBlock)(void);

@end

@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topMaskView];
        [self addSubview:self.bottomMaskView];
        [self addSubview:self.leftMaskView];
        [self addSubview:self.rightMaskView];
        [self addSubview:self.okBtn];
        [self addSubview:self.btnMaskView];
        [self addSubview:self.arrwoView];
        [self addSubview:self.tipsLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = _parentView.bounds;
    _maskBg.frame = self.bounds;
    _btnMaskView.center = [_maskTarget.superview convertPoint:_maskTarget.center toView:_maskTarget.superview];
    
    CGRect btnMaskRect = _btnMaskView.frame;//取图片大小
    btnMaskRect = _maskTarget.frame;//取目标frame
    btnMaskRect.size = CGSizeMake(floor(btnMaskRect.size.width), floor(btnMaskRect.size.height));
    btnMaskRect.origin = CGPointMake(floor(btnMaskRect.origin.x), floor(btnMaskRect.origin.y));
    _btnMaskView.frame = btnMaskRect;

    _topMaskView.left = 0;
    _topMaskView.top = 0;
    _topMaskView.height = _btnMaskView.top;
    _topMaskView.width = self.width;
    
    _bottomMaskView.left = 0;
    _bottomMaskView.top = _btnMaskView.bottom;
    _bottomMaskView.width = self.width;
    _bottomMaskView.height = self.height - _bottomMaskView.top;
    
    _leftMaskView.left = 0;
    _leftMaskView.top = _btnMaskView.top;
    _leftMaskView.width = _btnMaskView.left;
    _leftMaskView.height = _btnMaskView.height;
    
    _rightMaskView.left = _btnMaskView.right;
    _rightMaskView.top = _btnMaskView.top;
    _rightMaskView.width = self.width - _rightMaskView.left;
    _rightMaskView.height = _btnMaskView.height;
    
    
    _okBtn.centerX = self.width/2;
    _okBtn.bottom = MIN(MAX(_btnMaskView.bottom+100, self.bottom - 100), self.bottom - 100);
    
    BOOL up = _maskTarget.top<self.centerY;
    BOOL left = _maskTarget.centerX<self.centerX;

    if (up && left) {
        _arrwoView.top = _btnMaskView.bottom + 10;
        _tipsLabel.top = _arrwoView.bottom;
        
        _arrwoView.centerX = _btnMaskView.centerX + 10;
        _tipsLabel.left = _arrwoView.right;
        
        _arrwoView.image = [UIImage imageNamed:@"arrowLeftUp"];
    } else if (up && !left) {
        _arrwoView.top = _btnMaskView.bottom + 10;
        _tipsLabel.top = _arrwoView.bottom;
        
        _arrwoView.centerX = _btnMaskView.centerX - 10;
        _tipsLabel.right = _arrwoView.left;
        
        _arrwoView.image = [UIImage imageNamed:@"arrowRightUp"];
    } else if (!up && left) {
        _arrwoView.bottom = _btnMaskView.top - 10;
        _tipsLabel.bottom = _arrwoView.top + 0;
        
        _arrwoView.centerX = _btnMaskView.centerX + 10;
        _tipsLabel.left = _arrwoView.right;
        
        _arrwoView.image = [UIImage imageNamed:@"arrowRightDown"];
    } else {
        _arrwoView.bottom = _btnMaskView.top - 10;
        _tipsLabel.bottom = _arrwoView.top + 0;
        
        _arrwoView.centerX = _btnMaskView.centerX - 10;
        _tipsLabel.right = _arrwoView.left;
        
        _arrwoView.image = [UIImage imageNamed:@"arrowRightDown"];
    }
}

- (void)showInView:(UIView *)view maskTargets:(NSArray<UIView *> *)targetViews tapBlock:(void (^)(void))tapBlock {
    self.parentView = view;
    self.maskTarget = targetViews.firstObject;
    self.tapBlock = tapBlock;
    self.targetViews = targetViews;
    self.currentIndex = 1;
    
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:nil];
}

#pragma mark - Action

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self showNext];
}

- (void)handleButton:(UIButton *)sender {
    [self showNext];
}

- (void)showNext {
    if (self.currentIndex>=self.targetViews.count) {
        
        if (self.tapBlock) {
            self.tapBlock();
        }
        
        [self dismiss];
        return;
    }
    
    self.maskTarget = self.targetViews[self.currentIndex];
    self.currentIndex++;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - getter and setter

- (UIView *)maskBg {
    if (!_maskBg) {
        UIView *view = [[UIView alloc] init];
        _maskBg = view;
    }
    return _maskBg;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"okBtn"] forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        _okBtn = btn;
    }
    return _okBtn;
}

- (UIImageView *)btnMaskView {
    if (!_btnMaskView) {
        UIImage *image = [UIImage imageNamed:@"whiteMask"];
        image = [image maskImage:[[UIColor blackColor] colorWithAlphaComponent:0.71]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        _btnMaskView = imageView;
    }
    return _btnMaskView;
}

- (UIImageView *)arrwoView {
    if (!_arrwoView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowRightDown"]];
        _arrwoView = imageView;
    }
    return _arrwoView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.text = @"点击这里\n打开下一个页面";
        tipsLabel.numberOfLines = 0;
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.font = [UIFont systemFontOfSize:14];
        [tipsLabel sizeToFit];
        _tipsLabel = tipsLabel;
    }
    return _tipsLabel;
}

- (UIView *)topMaskView {
    if (!_topMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _topMaskView = view;
    }
    return _topMaskView;
}

- (UIView *)bottomMaskView {
    if (!_bottomMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _bottomMaskView = view;
    }
    return _bottomMaskView;
}

- (UIView *)leftMaskView {
    if (!_leftMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _leftMaskView = view;
    }
    return _leftMaskView;
}

- (UIView *)rightMaskView {
    if (!_rightMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _rightMaskView = view;
    }
    return _rightMaskView;
}

@end
