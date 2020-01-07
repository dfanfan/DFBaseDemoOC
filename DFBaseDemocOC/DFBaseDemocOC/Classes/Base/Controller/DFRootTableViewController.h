//
//  DFRootTableViewController.h
//  BaseDemo
//
//  Created by user on 4/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//
//

#import "DFRootViewController.h"
//#import "UITableView+List.h"
//#import "DFAPIParamas.h"

@interface DFRootTableViewController : DFRootViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;


/// 子类可以重写该方法来设置tableview距离导航栏的距离(默认0)
- (CGFloat)topOffset;

@end
