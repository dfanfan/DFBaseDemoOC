//
//  ViewController.m
//  DFBaseDemocOC
//
//  Created by user on 15/11/18.
//  Copyright © 2018年 DF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray<NSDictionary *> *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupNav];
    
    [self setupData];
}


#pragma mark private method
- (void)setupNav {
    self.leftBtn = nil;
    [self setTitle:@"功能列表"];
}

- (void)setupData {
    self.dataArray = @[@{@"DFRootTabBarController":@"自定义UITabBarController"},
                       @{@"DFAlertVC":@"Alert和hud"},
                       @{@"DFCommonViewVC":@"常用的View控件"},
                       @{@"DFShareVC":@"分享"},
                       @{@"DFCardVC":@"卡片效果"},
                       @{@"DFPlayerVC":@"视频播放（AVPlayer）"}];

}


- (void)toFunctionWithIndex:(NSUInteger)index {
    NSDictionary *dic = self.dataArray[index];
    NSString *clsName = [dic.allKeys firstObject];
    Class cls = NSClassFromString(clsName);
    UIViewController *vc = [[cls alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.dataArray[indexPath.row].allValues firstObject]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self toFunctionWithIndex:indexPath.row];
}


@end
