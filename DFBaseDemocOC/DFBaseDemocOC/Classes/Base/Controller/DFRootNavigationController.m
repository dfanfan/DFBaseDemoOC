//
//  DFRootNavigationController.h
//  BaseDemo
//
//  Created by user on 4/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//
//

#import "DFRootNavigationController.h"
#import "DFRootViewController.h"

@interface DFRootNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation DFRootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 创建一个全屏手势覆盖系统的方法
//    UIPanGestureRecognizer *popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    // 控制手势的触发,在代理方法中实现
//    popPanGesture.delegate = self;
//
////    [self.view addSubview:gestureView];
////    gestureView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//    // 把手势添加到self.view
//    [self.view addGestureRecognizer:popPanGesture];
//    // 关掉系统的边缘返回手势
//    self.interactivePopGestureRecognizer.enabled = NO;
    
    //隐藏导航栏
    [self setNavigationBarHidden:YES];
    /// 隐藏导航栏或添加自定义返回item 需要添加
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }

}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count != 1;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if ([self.visibleViewController isKindOfClass:[DFRootViewController class]]) {
        return [self.visibleViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}



#pragma mark ============ screen rotation
//-(BOOL)shouldAutorotate{
//    return [self.visibleViewController shouldAutorotate];
//}

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return [self.visibleViewController supportedInterfaceOrientations];
//}

@end
