//
//  MyTableViewCell.m
//  TableviewWithTimer
//
//  Created by ZZ on 2019/12/3.
//  Copyright © 2019 ZZ. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()
@property (nonatomic, strong) UILabel *lbName;

@end

@implementation MyTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lbName.frame = self.contentView.frame;
}

- (void)configCellVale:(ModeItem *)item indexPath:(NSIndexPath *)indexPath {
    self.lbName.text = [NSString stringWithFormat:@"%@ %@", item.name, item.count];
}

#pragma mark - Getter

- (UILabel *)lbName {
    if (!_lbName) {
        _lbName = [UILabel new];
        _lbName.textAlignment = 1;
        [self.contentView addSubview:_lbName];
    }
    return _lbName;
}

@end
