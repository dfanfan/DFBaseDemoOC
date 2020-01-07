//
//  DFCodeButton.h
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFCodeButton : UIButton

/// 默认标题，@"发送验证码"
@property (nonatomic, copy) NSString *normalTitle;

/// 发送时标题，@"正在发送"
@property (nonatomic, copy) NSString *sendingTitle;


/**功能：开始发送
 * return void
 */
- (void)startSend;

/**功能：发送失败
 * return void
 */
- (void)sendFailed;

/**功能：设置标题颜色和大小
 * @prama color 颜色
 * @prama size 大小
 * return void
 */
- (void)setTitleColor:(UIColor *)color andFontSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
