//
//  DFItemButton.h
//  Test1
//
//  Created by user on 7/7/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFItemButton : UIControl
// 是否有副标题
@property (nonatomic, assign) BOOL hasSubTitle;
// 是否右上角有红点
@property (nonatomic, assign) BOOL redCircle;

// 普通字体大小
@property (nonatomic, strong, nullable) UIFont *normalFont;
// 选中字体大小
@property (nonatomic, strong, nullable) UIFont *selectedFont;

- (void)setTitle:(nullable NSString *)title;

- (void)setSubTitleFont:(nullable UIFont *)font;

- (void)setSubTitle:(nullable NSString *)title;

- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state;

@end
