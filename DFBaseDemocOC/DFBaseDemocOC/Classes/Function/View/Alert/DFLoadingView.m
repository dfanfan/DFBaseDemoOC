//
//  DFLoadingView.m
//  DFBaseDemocOC
//
//  Created by user on 16/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFLoadingView.h"
#import <Masonry/Masonry.h>

#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees) ((pi * degrees)/ 180)

@implementation DFLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.equalTo(@90);
        make.width.equalTo(@140);
    }];
    
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.lineWidth = 5;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor =[UIColor colorWithRed:29.0/255 green:140.0/255 blue:224.0/255 alpha:1.0].CGColor;
    layer.frame = CGRectMake(45, 15, 50, 50);
    layer.lineCap = kCALineCapRound;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(25, 25) radius:25 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    //画一个圆
    CAKeyframeAnimation *strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 0.5;
    strokeEndAnimation.values = @[@0.0, @1];
    strokeEndAnimation.keyTimes = @[@0.0,@1];
    
    //旋转2圈
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotaAni.fromValue = @(DEGREES_TO_RADIANS(0));
    rotaAni.toValue = @(DEGREES_TO_RADIANS(720));
    rotaAni.autoreverses = YES;
    
    //最后填充颜色
    //创建一个CABasicAnimation对象
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //设置颜色
    animation.toValue=(id)[UIColor blackColor].CGColor; //必须要用黑色
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = INFINITY;
    group.duration = 2;
    group.animations = @[strokeEndAnimation,rotaAni,animation];
    
    [layer addAnimation:group forKey:nil];
}

- (void)dealloc {
    NSLog(@"==== CDALoadingView dealloc");
}

@end
