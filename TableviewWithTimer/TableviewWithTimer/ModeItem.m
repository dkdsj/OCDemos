//
//  ModeItem.m
//  TableviewWithTimer
//
//  Created by ZZ on 2019/12/3.
//  Copyright © 2019 ZZ. All rights reserved.
//

#import "ModeItem.h"

@implementation ModeItem

+ (instancetype)modeWithName:(NSString *)name count:(NSNumber *)count {
    ModeItem *item = [ModeItem new];
    item.name = name;
    item.count = count;
    return item;
}
@end
