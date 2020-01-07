//
//  DFRootTableViewController.m
//  BaseDemo
//
//  Created by user on 4/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//
//

#import "DFRootTableViewController.h"

@interface DFRootTableViewController ()

@end

@implementation DFRootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupTableView];

}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[self getTableViewStyle]];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.rowHeight = 50.0f;
    tableView.separatorColor = [UIColor grayColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    CGFloat topOffset = [self topOffset];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self hideNavView]) {
            make.top.equalTo(@(topOffset));
        }else {
            make.top.equalTo(self.navView.mas_bottom).offset(topOffset);
        }
        make.leading.trailing.bottom.equalTo(@0);
    }];
    
    UIView *view = [[UIView alloc] init];
    [tableView setTableFooterView:view];
    if (@available(iOS 11.0, *))  {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (UITableViewStyle)getTableViewStyle {
    return UITableViewStylePlain;
}

- (CGFloat)topOffset {
    return 0;
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

@end
