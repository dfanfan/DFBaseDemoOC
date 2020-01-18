//
//  DFGredienProgressView.m
//  DFGredientProgressView
//
//  Created by dff on 2020/1/16.
//  Copyright © 2020 dff. All rights reserved.
//

#import "DFGredienProgressView.h"


@interface DFGredienProgressView ()

@property (nonatomic, assign) CGFloat progress;

@end

@implementation DFGredienProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfige];
    }
    return self;
}

- (void)defaultConfige {
    self.lineWidth = 10;
    self.progress = 1;
}

- (void)updateWithProgress:(CGFloat)progress {
    self.progress = progress;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGFloat originX = rect.size.width / 2;
    CGFloat originY = rect.size.height / 2;
    
    // 计算半径
    CGFloat radius = MIN(originX, originY);
    // clockwise 为1是，圆弧是逆时针，0的时候就是顺时针
    // 画一个圆弧
    CGFloat startAngle = M_PI_2 * 3;
    CGFloat endAngle = startAngle + self.progress * 2 * M_PI;
    CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, radius-self.lineWidth/2, startAngle, endAngle, 0);
    // 2. 创建一个渐变色
    // 创建RGB色彩空间，创建这个以后，context里面用的颜色都是用RGB表示
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 渐变色的颜色
    NSArray *colorArr = @[
        (id)[UIColor colorWithRed:255/255.0 green:110/255.0 blue:2/255.0 alpha:1.0].CGColor,
        (id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:0/255.0 alpha:1.0].CGColor
                          ];
    
    CGFloat locations[2];
    locations[0] = 0.0;
    locations[1] = 0.5;
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorArr, locations);
    // 释放色彩空间
    CGColorSpaceRelease(colorSpace);
    colorSpace = NULL;
    
    // ----------以下为重点----------
    // 3. "反选路径"
    // CGContextReplacePathWithStrokedPath
    // 将context中的路径替换成路径的描边版本，使用参数context去计算路径（即创建新的路径是原来路径的描边）。用恰当的颜色填充得到的路径将产生类似绘制原来路径的效果。你可以像使用一般的路径一样使用它。例如，你可以通过调用CGContextClip去剪裁这个路径的描边
    CGContextReplacePathWithStrokedPath(context);
    // 剪裁路径
    CGContextClip(context);
    
    // 4. 用渐变色填充
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, rect.size.height),CGPointMake(rect.size.height, 0),  0);
    // 释放渐变色
    CGGradientRelease(gradient);
}


@end
