//
//  ViewController.m
//  TableviewWithTimer
//
//  Created by ZZ on 2019/12/3.
//  Copyright © 2019 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)startTimer {
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)initData {
    NSMutableArray *m = [NSMutableArray array];
    for (int i = 1; i < 500; i++) {
        [m addObject:[ModeItem modeWithName:[NSString stringWithFormat:@"lable %d", i] count:@(i*10000)]];
    }
    self.items = m;
    
    [self.myTableView reloadData];
    
}

#pragma mark - Action

/**
 将时间数据转换为天和小时
 ms:YES毫秒 NO秒
*/
- (NSString *)getCountingTime:(NSInteger)second mSecond:(BOOL)ms {
    if (second <= 0) {
        return @"已结束";
    }
    
    NSInteger sec = ms?second/1000:second;
    NSInteger d = sec/60/60/24;
    NSInteger h = sec/60/60%24;
    NSInteger m = sec/60%60;
    NSInteger s = sec%60;
      
    NSString *dStr = @"";
    NSString *hStr = @"";
      
    if (d >= 0) {
        dStr = [NSString stringWithFormat:@"%ld天",d];
    }
      
    if (h >= 0) {
        hStr = [NSString stringWithFormat:@"%.2zd",h];
    }
      
    return [NSString stringWithFormat:@"%@%@:%.2zd:%.2zd",dStr, hStr, m, s];
}

- (void)updateTimer {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (ModeItem *item in self.items) {
            NSInteger count = item.count.integerValue;
            if (count<=0) {
                count = 0;
            } else {
                count = count-1;
            }
            
            item.count = @(count);
            item.name = [self getCountingTime:count mSecond:NO];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    });
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    [cell configCellVale:_items[indexPath.row] indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        [_myTableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell class])];
        _myTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        _myTableView.estimatedRowHeight = 44;
        _myTableView.tableFooterView = [UIView new];
        
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}



@end
