//
//  AViewController.m
//  TableviewWithTimer
//
//  Created by ZZ on 2019/12/3.
//  Copyright © 2019 ZZ. All rights reserved.
//

#import "AViewController.h"
#import "ViewController.h"

@implementation AViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

@end
