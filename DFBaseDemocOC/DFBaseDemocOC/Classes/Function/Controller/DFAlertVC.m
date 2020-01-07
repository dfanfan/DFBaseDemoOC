//
//  DFAlertVC.m
//  DFBaseDemocOC
//
//  Created by user on 16/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFAlertVC.h"
#import "DFAlertTool.h"
#import "MBHud.h"


@interface DFAlertVC ()
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DFAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    [self setupData];
    
}

- (void)setupNav {
    [self setTitle:@"系统对话框和自定义对话框"];
}


- (void)setupData {
    self.dataArray = @[@"系统Alert",
                       @"自定义ActionSheet",
                       @"加载提示框",
                       @"显示提示语",
                       @"成功提示后有回调",
                       @"自定义加载提示"];
    
}

- (void)systemAlert {
    [DFAlertTool alertTitle:@"提示"
                    message:@"提示信息"
                cancelTitle:@"取消"
               confirmTitle:@"确定"
             viewController:self
              cancelHandler:nil
             confirmHandler:^(UIAlertAction * _Nonnull confirmAction) {
        NSLog(@"点击确定");
    }];
}

- (void)actionSheet {
    NSArray *dataArray = @[@"action 1",
                           @"action 2"];
    [DFAlertTool actionSheetWithArray:dataArray
                       viewController:self
                      selectedHandler:^(NSUInteger index) {
        NSLog(@"index = %ld", index);
    }];
}

- (void)showHud {
    [MBHud showHudInView:nil];
    
    [self performSelector:@selector(hideHud) withObject:nil afterDelay:5];
}

- (void)showHudWithHint {
    [MBHud showHudInView:nil hint:@"提示"];
}

- (void)showHudSuccess {
    [MBHud showSuccessWithHint:@"请求成功" andView:nil success:^{
        NSLog(@"提示成功");
    }];
}


- (void)showCustom {
    [MBHud showLoadingView:nil hint:@"加载中" andMask:YES];
    
    [self performSelector:@selector(hideHud) withObject:nil afterDelay:5];

}


- (void)hideHud {
    [MBHud hideHud];
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
            [self systemAlert];
            break;
        case 1:
            [self actionSheet];
            break;
        case 2:
            [self showHud];
            break;
        case 3:
            [self showHudWithHint];
            break;
        case 4:
            [self showHudSuccess];
            break;
        case 5:
            [self showCustom];
            break;
            
        default:
            break;
    }
}



-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

@end
