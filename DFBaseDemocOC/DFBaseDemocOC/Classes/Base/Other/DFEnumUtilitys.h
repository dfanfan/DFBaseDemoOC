//
//  DFEnumUtilitys.h
//  BaseDemo
//
//  Created by user on 4/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFEnumUtilitys : NSObject
/// 手机类型
typedef NS_ENUM(NSUInteger, DFAIphoneType)
{
    DFIphoneType4,
    DFIphoneType5,
    DFIphoneType6,
    DFIphoneTypePlus,
    DFIphoneTypeX,
    DFIphoneTypeUnknow
};

@end
