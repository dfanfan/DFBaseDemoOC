//
//  DFActionSheetVC.m
//  DFBaseDemocOC
//
//  Created by user on 16/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFActionSheetVC.h"
#import <Masonry/Masonry.h>
#import "DFHelper.h"


@interface DFActionSheetVC ()
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIButton *bgBtn;
@end
@implementation DFActionSheetVC

- (instancetype)initWithArray:(nullable NSArray<NSString *> *)dataArray {
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

#pragma mark 重写父类方法
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showAnimation];
}


#pragma mark UI界面
- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    UIButton *bgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    [bgBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgBtn];
    self.bgBtn = bgBtn;
    
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor colorWithRed:211.0/255 green:223.0/255 blue:239.0/255 alpha:1.0];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.top.equalTo(self.view.mas_bottom);
    }];
    
    
    UIButton *lastBtn = nil;
    for (NSUInteger i = 0; i < self.dataArray.count; i++) {
        NSString *title = self.dataArray[i];
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(@0);
            make.height.equalTo(@50);
            make.top.equalTo(@(50.5*i));
        }];
        
        lastBtn = btn;
    }
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];;
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelBtn];
    
    CGFloat height = [DFHelper judgeIphoneType] == DFIphoneTypeX ? 60 : 50;
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(@0);
        make.top.equalTo(lastBtn.mas_bottom).offset(5);
        make.height.equalTo(@(height));
    }];
}



#pragma mark UIAction
- (void)clickCancelBtn {
    [self hideAnimation];
}

- (void)clickBtn:(UIButton *)sender {
    if (self.selectedBlock) {
        self.selectedBlock(sender.tag);
    }
    [self hideAnimation];
}

#pragma mark private method
- (void)showAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -(CGRectGetHeight(self.contentView.bounds)));
    }];
}

- (void)hideAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


#pragma mark public method





@end
