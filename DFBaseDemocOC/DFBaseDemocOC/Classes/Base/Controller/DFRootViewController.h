//
//  DFRootViewController.h
//  BaseDemo
//
//  Created by user on 4/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "DFMacros.h"



@interface DFRootViewController : UIViewController
//导航栏
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *leftBtn;

/// 子类可以重写该方法来隐藏navView
- (BOOL)hideNavView;

/**功能：设置导航栏底部线条
 * @param hiden 是否隐藏
 * return void
 */
- (void)setBottomLine:(BOOL)hiden;

/**功能：设置导航栏标题
 * @param title 标题
 * return void
 */
- (void)setTitle:(NSString *)title;

/**功能：设置导航栏标题和颜色
 * @param title 标题
 * @param color 颜色
 * return void
 */
- (void)setTitle:(NSString *)title andColor:(UIColor *)color;

/**功能：可以设置标题为图片
 * @param titleImage 标题图片
 * return void
 */
- (void)setTitleImage:(UIImage *)titleImage;

/**功能：设置右侧按钮
 * @param buttons
 * return void
 */
- (void)setRightButtons:(NSArray *)buttons;

@end
