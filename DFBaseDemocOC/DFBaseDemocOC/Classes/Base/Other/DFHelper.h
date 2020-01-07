//
//  DFHelper.h
//  BaseDemo
//
//  Created by user on 4/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DFEnumUtilitys.h"

@interface DFHelper : NSObject

/// 判断手机类型
+ (DFAIphoneType)judgeIphoneType;


/// 跳转AppStore
+ (void)toAppStore;

@end
