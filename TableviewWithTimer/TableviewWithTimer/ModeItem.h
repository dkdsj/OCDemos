//
//  ModeItem.h
//  TableviewWithTimer
//
//  Created by ZZ on 2019/12/3.
//  Copyright © 2019 ZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModeItem : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *count;

+ (instancetype)modeWithName:(NSString *)name count:(NSNumber *)count;

@end

NS_ASSUME_NONNULL_END
