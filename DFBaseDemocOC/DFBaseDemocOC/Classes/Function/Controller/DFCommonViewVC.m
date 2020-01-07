//
//  DFCommonViewVC.m
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFCommonViewVC.h"
#import "DFCodeButton.h"
#import "DFBadgeView.h"
#import "UIColor+Utility.h"
#import "DFKeyBoardView.h"
#import "UIView+KeyBoardDismiss.h"
#import "DFTextField.h"

@interface DFCommonViewVC ()
@property (nonatomic, weak) DFBadgeView *badgeView;
@property (nonatomic, weak) DFKeyBoardView *containView;
@end

@implementation DFCommonViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCodeBtn];
    
    [self setupBadgeView];
    
    [self setupTextField];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.containView addKeyboardNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.containView removeKeyboardNotification];
}

- (void)setupCodeBtn {
    DFCodeButton *codeBtn = [[DFCodeButton alloc] init];
    codeBtn.backgroundColor = [UIColor randomColor];
    [self.view addSubview:codeBtn];
    
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@20);
        make.top.equalTo(@100);
        make.width.equalTo(@110);
        make.height.equalTo(@45);
    }];
    
    [codeBtn addTarget:self action:@selector(clickCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickCodeBtn:(DFCodeButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender startSend];
    });
    
    [self.badgeView setNum:0];
}


- (void)setupBadgeView {
    DFBadgeView *badgeView = [[DFBadgeView alloc] init];
    [self.view addSubview:badgeView];
    self.badgeView = badgeView;
    
    [badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@200);
        make.top.equalTo(@115);
        make.height.equalTo(@20);
    }];
    
    [badgeView setNum:10];
}


- (void)setupTextField {
    [self.view setupKeyboardDismiss];
    
    DFKeyBoardView *containView = [[DFKeyBoardView alloc] init];
    containView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:containView];
    self.containView = containView;

    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(@0);
        make.height.equalTo(@200);
    }];
    
    DFTextField *textField = [[DFTextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    [containView addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(@50);
        make.trailing.equalTo(@-50);
        make.height.equalTo(@40);
    }];
    
    containView.keyboardBelowView = textField;
    containView.moveOffset = 10;
}

- (void)dealloc {
    [self.view removeKeyboardDismiss];
}




@end
