//
//  UIColor+Utility.h
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Utility)

// 十六进制字符串转换成颜色对象
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(float)alpha;

/// 随机颜色
+ (UIColor *)randomColor;

@end

NS_ASSUME_NONNULL_END
