//
//  ViewController.m
//  GuideDemo
//
//  Created by 李剑钊 on 15/7/23.
//  Copyright (c) 2015年 sunli. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Layout.h"
#import "GuideView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *lbTest;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    GuideView *guide = [GuideView new];
    [guide showInView:self.view maskTargets:@[_btn1, _btn2, _btn3, _lbTest, _btn4, _btn5] tapBlock:^{
        NSLog(@"完了😰");
    }];
}

- (IBAction)showGuideView:(id)sender {
    GuideView *guide = [GuideView new];
   [guide showInView:self.view maskTargets:@[_btn1, _btn2, _btn3, _lbTest, _btn4, _btn5] tapBlock:^{
       NSLog(@"完了😰");
   }];
}



@end
