//
//  GuideView.h
//  GuideDemo
//
//  Created by 李剑钊 on 15/7/23.
//  Copyright (c) 2015年 sunli. All rights reserved.
//  https://github.com/sunljz/demo

#import <UIKit/UIKit.h>

@interface GuideView : UIView

- (void)showInView:(UIView *)view maskTargets:(NSArray<UIView *> *)targetViews tapBlock:(void (^)(void))tapBlock;

@end
