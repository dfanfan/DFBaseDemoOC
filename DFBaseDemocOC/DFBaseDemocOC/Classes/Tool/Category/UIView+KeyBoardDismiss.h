//
//  UIView+KeyBoardDismiss.h
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KeyBoardDismiss)

/// 添加键盘通知
- (void)setupKeyboardDismiss;

/// 移除通知
- (void)removeKeyboardDismiss;

@end

NS_ASSUME_NONNULL_END
