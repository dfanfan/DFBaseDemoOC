//
//  DFMacros.h
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/10.
//  Copyright © 2020 DF. All rights reserved.
//

#ifndef DFMacros_h
#define DFMacros_h

#import "DFFontMacros.h"
#import "DFColorMacros.h"
#import <Masonry/Masonry.h>


#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif


#define NULL_OBJECT(object) ((object) ? : @"")

// 自定义的工具类
#define weakSelf() __weak __typeof__(self) weakSelf = self

#define nilOrJSONObjectForKey(JSON_, KEY_) [JSON_ objectForKey:KEY_] == [NSNull null] ? nil : [JSON_ valueForKeyPath:KEY_]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* DFMacros_h */
