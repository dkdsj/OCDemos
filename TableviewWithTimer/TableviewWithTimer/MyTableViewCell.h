//
//  MyTableViewCell.h
//  TableviewWithTimer
//
//  Created by ZZ on 2019/12/3.
//  Copyright © 2019 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell

- (void)configCellVale:(ModeItem *)item indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
