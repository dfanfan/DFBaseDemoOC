//
//  DFHelper.m
//  BaseDemo
//
//  Created by user on 4/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import "DFHelper.h"
#import <UIKit/UIKit.h>

@implementation DFHelper

/// 判断手机类型
+ (DFAIphoneType)judgeIphoneType {
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (height == 480) {
        return DFIphoneType4;
    } else if (height == 568) {
        return DFIphoneType5;
    } else if (height == 667) {
        return DFIphoneType6;
    } else if (height == 736) {
        return DFIphoneTypePlus;
    } else if (height == 812) {
        return DFIphoneTypeX;
    } else if (height == 896) {
        return DFIphoneTypeX;
    }
    return DFIphoneTypeUnknow;
}

/// 计算字体的高度
+ (CGFloat)getStringHeightWith:(NSString *)string andWidth:(CGFloat)width andFontSize:(CGFloat)size {
//    CGFloat height = 0;
//    UIFont *font = [UIFont systemFontOfSize:size];
//
//    //返回字符串所占用的尺寸.
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    height = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
//
//    return height+10;
    return [self stringHeightWithString:string width:width andFont:[UIFont systemFontOfSize:size]];

}

/// 计算字体的高度
+ (CGFloat)getStringHeightWith:(NSString *)string andWidth:(CGFloat)width andFont:(UIFont *)font {
//    if (string.length == 0) {
//        return 0;
//    }
//    CGFloat height = 0;
//
//    //返回字符串所占用的尺寸.
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    height = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
//
//    return height+10;
    return [self stringHeightWithString:string width:width andFont:font];
}

+ (CGFloat)stringHeightWithString:(NSString *)string width:(CGFloat)width andFont:(UIFont *)font {
    if (string.length == 0) {
        return 0;
    }
    static const UILabel *label = nil;
    if (!label) {
        label = [[UILabel alloc] init];
    }
    label.text = string;
    label.font = font;
    label.numberOfLines = 0;
    label.frame = CGRectMake(0, 0, width, MAXFLOAT);
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height + 5;
}




/// 跳转AppStore
+ (void)toAppStore {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
}


@end
