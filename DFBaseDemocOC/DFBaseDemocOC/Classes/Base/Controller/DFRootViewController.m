//
//  DFRootViewController.m
//  BaseDemo
//
//  Created by user on 4/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//
//

#import "DFRootViewController.h"
#import "DFHelper.h"

#define ButtonWidth 50

@interface DFRootViewController ()
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *buttons;

@property (nonatomic, assign) CGFloat statusHeight;
@end

@implementation DFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
    //
    self.view.backgroundColor = [UIColor whiteColor];

    if ([self hideNavView]) {
        return;
    }
    [self initNavView];
}

- (BOOL)hideNavView {
    return NO;
}



#pragma mark ============ InitUI
- (void)initNavView{
    //导航栏
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:navView];
    self.navView = navView;
    float navHeight = 64;
    self.statusHeight = 20;
    
    if ([DFHelper judgeIphoneType] == DFIphoneTypeX) {
        navHeight = 88;
        self.statusHeight = 44;
    }
    
    //约束数组
    NSMutableArray *tempConstraints = [NSMutableArray array];
    [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeLeft firstView:navView]];
    [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeRight firstView:navView]];
    [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeTop firstView:navView]];
    [tempConstraints addObject:[self constant:navHeight withType:NSLayoutAttributeHeight firstView:navView secondView:nil]];
    [self.view addConstraints:tempConstraints];
    
    
    //状态栏
    UIView *statusView = [[UIView alloc] init];
//    statusView.backgroundColor = [UIColor whiteColor];
    [navView addSubview:statusView];

    [tempConstraints removeAllObjects];
    [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeLeft firstView:statusView]];
    [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeRight firstView:statusView]];
    [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeTop firstView:statusView]];
    [tempConstraints addObject:[self constant:self.statusHeight withType:NSLayoutAttributeHeight firstView:statusView secondView:nil]];
    [navView addConstraints:tempConstraints];
    
    
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [navView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        if ([self hideNavView]) {
            // 如果不存在自定义导航栏，其它UI也不生效
            return nil;
        }
        UIView *lineView = [[UIView alloc] init];
//        lineView.backgroundColor = COLOR_LINE;
        [self.navView addSubview:lineView];
        self.lineView = lineView;
    
        NSMutableArray *tempConstraints = [NSMutableArray array];
        [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeLeft firstView:lineView]];
        [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeRight firstView:lineView]];
        [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeBottom firstView:lineView]];
        [tempConstraints addObject:[self constant:0.5 withType:NSLayoutAttributeHeight firstView:lineView secondView:nil]];
        [self.navView addConstraints:tempConstraints];
    }
    
    return _lineView;
}


- (UIButton *)titleButton {
    if (!_titleButton) {
        if ([self hideNavView]) {
            // 如果不存在自定义导航栏，其它UI也不生效
            return nil;
        }
        //标题view
        UIButton *titleView = [[UIButton alloc] init];
        titleView.titleLabel.font = [UIFont systemFontOfSize:20.0];//NAV_TITLE_FONT;
        titleView.backgroundColor = [UIColor clearColor];
        titleView.enabled = NO;
        [self.navView addSubview:titleView];
        _titleButton = titleView;
        
        NSMutableArray *tempConstraints = [NSMutableArray array];
        [tempConstraints addObject:[self constant:ButtonWidth withType:NSLayoutAttributeLeft firstView:titleView]];
        [tempConstraints addObject:[self constant:-(ButtonWidth) withType:NSLayoutAttributeRight firstView:titleView]];
        [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeBottom firstView:titleView]];
        [tempConstraints addObject:[self constant:self.statusHeight withType:NSLayoutAttributeTop firstView:titleView]];
        [self.navView addConstraints:tempConstraints];
    }
    return _titleButton;
}



#pragma mark ============ NSLayoutConstraint
-(NSLayoutConstraint *)constant:(CGFloat)offset withType:(NSLayoutAttribute)attribute firstView:(UIView *)firstView secondView:(UIView *)secondView{
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    //    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    return [NSLayoutConstraint constraintWithItem:firstView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:secondView attribute:attribute multiplier:1.0 constant:offset];
}

-(NSLayoutConstraint *)constant:(CGFloat)offset withFirstType:(NSLayoutAttribute)firstAttribute firstView:(UIView *)firstView andSecondType:(NSLayoutAttribute)secondAttribute secondView:(UIView *)secondView{
    return [NSLayoutConstraint constraintWithItem:firstView attribute:firstAttribute relatedBy:NSLayoutRelationEqual toItem:secondView attribute:secondAttribute multiplier:1.0 constant:offset];
}

-(NSLayoutConstraint *)constant:(CGFloat)offset withType:(NSLayoutAttribute)attribute firstView:(UIView *)firstView{
    UIView *secondView = [firstView superview];
    return [self constant:offset withType:attribute firstView:firstView secondView:secondView];
}


#pragma mark ============ public method
- (void)setBottomLine:(BOOL)hiden {
    if (hiden) {
        _lineView.hidden = YES;
    } else {
        self.lineView.hidden = NO;
    }
}


- (void)setTitle:(NSString *)title{
    [self setTitle:title andColor:[UIColor whiteColor]];
    
}

- (void)setTitle:(NSString *)title andColor:(UIColor *)color{
    [self.titleButton setTitle:title forState:UIControlStateDisabled];
    [self.titleButton setTitleColor:color forState:UIControlStateDisabled];
}

-(void)setTitleImage:(UIImage *)titleImage{
    [self.titleButton setImage:titleImage forState:UIControlStateDisabled];
}

-(void)setLineHiden:(BOOL)hiden{
    [self.lineView setHidden:hiden];
}

- (void)setRightButtons:(NSArray *)buttons{
    for (UIButton *button in self.buttons) {
        //将原来的button移除
        [button removeFromSuperview];
    }
    if (!buttons) {
        self.buttons = nil;
        return;
    }
    
    int i = 0;
    for (UIButton *button in buttons) {
        //添加新的button
        [self.navView addSubview:button];
        NSMutableArray *tempConstraints = [NSMutableArray array];
        //偏移5
        [tempConstraints addObject:[self constant:-(i*ButtonWidth+5) withType:NSLayoutAttributeRight firstView:button]];
        [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeBottom firstView:button]];
        [tempConstraints addObject:[self constant:ButtonWidth withType:NSLayoutAttributeWidth firstView:button secondView:nil]];
        [tempConstraints addObject:[self constant:self.statusHeight withType:NSLayoutAttributeTop firstView:button]];
        [self.navView addConstraints:tempConstraints];
        i++;
    }
    self.buttons = buttons;
}


#pragma mark ============ leftBtn set method
-(void)setLeftBtn:(UIButton *)leftBtn{
    if (_leftBtn) {
        [_leftBtn removeFromSuperview];
    }
    _leftBtn = leftBtn;
    if (!leftBtn) {
        //设置为空直接return
        return;
    }
    [self.navView addSubview:_leftBtn];
    NSMutableArray *tempConstraints = [NSMutableArray array];
    [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeLeft firstView:leftBtn]];
    [tempConstraints addObject:[self constant:0 withType:NSLayoutAttributeBottom firstView:leftBtn]];
    [tempConstraints addObject:[self constant:ButtonWidth withType:NSLayoutAttributeWidth firstView:leftBtn secondView:nil]];
    [tempConstraints addObject:[self constant:self.statusHeight withType:NSLayoutAttributeTop firstView:leftBtn]];
    [self.navView addConstraints:tempConstraints];
}

#pragma mark ============ UIAction method
//返回
-(void)navBack{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}



#pragma mark ============ system method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//解决iOS9使用该方法改变状态栏颜色会报警
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)dealloc {
    NSLog(@"====== %@ dealloc", NSStringFromClass([self class]));
}

@end
