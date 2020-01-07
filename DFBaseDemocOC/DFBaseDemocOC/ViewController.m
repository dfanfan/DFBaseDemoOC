//
//  ViewController.m
//  DFBaseDemocOC
//
//  Created by user on 15/11/18.
//  Copyright © 2018年 DF. All rights reserved.
//

#import "ViewController.h"
#import "DFRootTabBarController.h"
#import "DFAlertVC.h"
#import "DFCommonViewVC.h"
#import "DFShareVC.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *dataArray;
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
    self.dataArray = @[@"自定义UITabBarController",
                       @"Alert和hud",
                       @"常用的View控件",
                       @"分享"];
    
}


- (void)toTabController {
    DFRootTabBarController *vc = [[DFRootTabBarController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)toAlert {
    DFAlertVC *vc = [[DFAlertVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)toCommonView {
    DFCommonViewVC *vc = [[DFCommonViewVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)toShare {
    DFShareVC *vc = [[DFShareVC alloc] init];
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self toTabController];
            break;
        case 1:
            [self toAlert];
            break;
        case 2:
            [self toCommonView];
            break;
        case 3:
            [self toShare];
            break;
            
        default:
            break;
    }
}


@end
