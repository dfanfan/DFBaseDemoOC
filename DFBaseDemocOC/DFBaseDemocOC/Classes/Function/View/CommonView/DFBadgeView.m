//
//  DFBadgeView.m
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFBadgeView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Utility.h"

@interface DFBadgeView ()
@property (nonatomic, weak) UILabel *numLabel;
@property (nonatomic, weak) CAGradientLayer *gradientLayer;
@property (nonatomic, weak) CAShapeLayer *shapeLayer;
@end

@implementation DFBadgeView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    CAGradientLayer *gradientLayer= [[CAGradientLayer alloc] init];
    [self.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
    
    UIColor *startColor = [UIColor colorWithHexString:@"#ff4949"];
    UIColor *endColor = [UIColor colorWithHexString:@"#ff5f5f" andAlpha:0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.textColor = [UIColor whiteColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.text = @"0";
    numLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:numLabel];
    self.numLabel = numLabel;
    
    float offSet = 5;
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.leading.greaterThanOrEqualTo(@(offSet)).priorityHigh();
        make.trailing.lessThanOrEqualTo(@(-offSet)).priorityHigh();
    }];
    
    self.hidden = YES;
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer = shapeLayer;

}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    
    self.gradientLayer.frame = bounds;
    
    CGSize radioSize = CGSizeMake(bounds.size.height / 2, bounds.size.height / 2);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:radioSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setNum:(NSUInteger)num {
    if (num == 0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
        self.numLabel.text = [NSString stringWithFormat:@"%ld", num];
    }
}



@end
