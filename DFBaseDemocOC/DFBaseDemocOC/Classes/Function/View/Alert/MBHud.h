//
//  MBHud.h
//  DFBaseDemocOC
//
//  Created by user on 16/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBHud : NSObject

/**功能：显示默认转圈圈提示框
 * @param view 父控件
 * return void
 */
+ (void)showHudInView:(nullable UIView *)view;

/**功能：加载是否遮盖
 * @param view 父控件
 * return void
 */
+ (void)showHudInView:(nullable UIView *)view andMask:(BOOL) isMask;

/**功能：显示提示语
 * @param view 父控件
 * return void
 */
+ (void)showHudInView:(nullable UIView *)view hint:(nullable NSString *)hint;

//显示提示语是否遮盖
//- (void)showHudInView:(UIView *)view hint:(NSString *)hint andMask:(BOOL) isMask;


/**功能：成功后提示
 * @param hint 提示语
 * @param view 父控件
 * @param success 提示完成后回调
 * return void
 */
+ (void)showSuccessWithHint:(nullable NSString*)hint andView:(nullable UIView *)view success:(nullable void (^)(void))success;

/**功能：失败后提示
 * @param hint 提示语
 * @param view 父控件
 * return void
 */
+ (void)showErrorWithHint:(nullable NSString *)hint andView:(nullable UIView *)view;

/**功能：进度是否遮盖
 * @param view 父控件
 * @param progress 进度
 * return void
 */
+ (void)showHudInView:(nullable UIView *)view progress:(float)progress andMask:(BOOL)isMask;

/**功能：隐藏
 * return void
 */
+ (void)hideHud;

/**功能：显示加载提示和是否遮盖
 * @param view 父控件
 * return void
 */
+ (void)showLoadingView:(nullable UIView *)view hint:(nullable NSString *)hint andMask:(BOOL)isMask;

@end

NS_ASSUME_NONNULL_END
