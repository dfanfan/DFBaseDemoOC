//
//  DFCodeButton.m
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFCodeButton.h"


#define kSecond 60

@interface DFCodeButton()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) int seconds;
@property (nonatomic, strong) UILabel *tempLabel;
@end

@implementation DFCodeButton

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaultData];
        [self setupUI];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultData];
        [self setupUI];
    }
    return self;
}

- (void)setupDefaultData {
    _normalTitle = @"发送验证码";
    _sendingTitle = @"正在发送";
}

-(void) setupUI{
    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.seconds = kSecond;
    [self setTitle:self.normalTitle forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
}

-(void)click:(id)sender{
    if (!self.tempLabel) {
        self.tempLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.tempLabel.textColor = self.titleLabel.textColor;
        self.tempLabel.backgroundColor = [UIColor whiteColor];
        self.tempLabel.textAlignment = NSTextAlignmentCenter;
        self.tempLabel.font = self.titleLabel.font;
        self.tempLabel.userInteractionEnabled = YES;
    }
    [self insertSubview:self.tempLabel aboveSubview:self.titleLabel];
    
    self.tempLabel.text = self.sendingTitle;
}

-(void)changeSeconds{
    if (self.seconds > 0) {
        self.seconds--;
        NSString *titleStr = [NSString stringWithFormat:@"%d秒后重发", self.seconds];
        self.tempLabel.text = titleStr;
    }else{
        [self.timer invalidate];
        self.seconds = kSecond;
        [self.tempLabel removeFromSuperview];
    }
}

/// 开始发送
- (void)startSend {
    self.tempLabel.text = [NSString stringWithFormat:@"%d秒后重发", self.seconds];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeSeconds) userInfo:nil repeats:YES];
}


-(void)sendFailed {
    self.seconds = 0;
    [self changeSeconds];
}

/// 设置标题颜色和大小
- (void)setTitleColor:(UIColor *)color andFontSize:(CGFloat)size {
    [self setTitleColor:color forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:size];
}


-(void)dealloc{
    NSLog(@"===== DFCodeButton dealloc");
    //    [self.timer invalidate];
}

@end
