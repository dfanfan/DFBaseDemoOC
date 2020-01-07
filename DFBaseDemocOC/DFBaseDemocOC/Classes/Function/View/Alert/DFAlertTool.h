//
//  DFAlertTool.h
//  DFBaseDemocOC
//
//  Created by user on 16/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DFActionSheetVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFAlertTool : NSObject

/**功能：创建系统弹出框
 * @param title 标题
 * @param message 提示信息
 * @param cancelTitle 取消标题
 * @param confirmTitle 确定标题
 * @param vc 当前控制器
 * @param cancelActionHandler 取消回调
 * @param confirmActionHandler 确定回调
 * return void
 */
+ (void)alertTitle:(nullable NSString *)title
           message:(nullable NSString *)message
       cancelTitle:(nullable NSString *)cancelTitle
      confirmTitle:(nullable NSString *)confirmTitle
    viewController:(UIViewController *)vc
     cancelHandler:(nullable void(^)(UIAlertAction *cancelAction))cancelActionHandler
    confirmHandler:(nullable void(^)(UIAlertAction *confirmAction))confirmActionHandler;


/**功能：创建自定义ActionSheet
 * @param dataArray 标题
 * @param vc 当前控制器
 * @param selectedHandler 选定index回调
 * return void
 */
+ (void)actionSheetWithArray:(nullable NSArray<NSString *> *)dataArray
              viewController:(UIViewController *)vc
               selectedHandler:(void(^)(NSUInteger index))selectedHandler;



@end

NS_ASSUME_NONNULL_END
