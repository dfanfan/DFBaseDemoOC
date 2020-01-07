//
//  RootTabBarController.m
//  BaseDemo
//
//  Created by user on 29/3/17.
//  Copyright © 2017年 Camdora. All rights reserved.
//

#import "DFRootTabBarController.h"
#import "DFRootViewController.h"
#import "DFRootNavigationController.h"


@interface DFRootTabBarController ()

@end

@implementation DFRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];

    [self setupChildControllers];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)setupChildControllers {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        UIViewController *vc = [self controllerWithDict:dict];
        [mArray addObject:vc];
    }
    self.viewControllers = mArray;

    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
    self.tabBar.barStyle = UIBarStyleBlack;
    
    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
    self.tabBar.layer.shadowOpacity = 0.1;
}


- (UIViewController *)controllerWithDict:(NSDictionary *)dict{
    NSString *clsName = dict[@"clsName"];
    NSString *title = dict[@"title"];
    NSString *imageName = dict[@"imageName"];
    Class cls = NSClassFromString(clsName);
    DFRootViewController *vc = (DFRootViewController *)[[cls alloc] init];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_pre", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);;
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11.0]} forState:UIControlStateNormal];
    vc.tabBarItem.title = title;
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);

    DFRootNavigationController *nav = [[DFRootNavigationController alloc] initWithRootViewController:vc];

    
    return nav;
    
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self selectedViewController] supportedInterfaceOrientations];
}





@end
