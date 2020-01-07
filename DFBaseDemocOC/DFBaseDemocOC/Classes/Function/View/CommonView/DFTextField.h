//
//  DFTextField.h
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 手机类型
typedef NS_ENUM(NSUInteger, DFTextFieldType)
{
    DFTextFieldTypeAny,         //没有限制
    DFTextFieldTypeUnsignInt,   //只允许非负整型
    DFTextFieldTypeOnlyInt,     //只允许整型输入
    DFTextFieldTypeForbidEmoj   //禁止Emoj表情输入
};

/// 手机类型
typedef NS_ENUM(NSUInteger, DFTextFieldEvent)
{
    DFTextFieldEventBegin,       //开始编辑
    DFTextFieldEventEnd   //输入完成
};

@interface DFTextField : UITextField
/**
 *  如果按了return需要让键盘收起
 */
@property(nonatomic,assign) BOOL isResignKeyboardWhenTapReturn;
/**
 *  输入类型
 */
@property(nonatomic,assign) DFTextFieldType inputType;

/**
 *  最大字符数
 */
@property(nonatomic,assign) NSInteger maxLength;

/**
 *  最大字节数
 */
@property(nonatomic,assign) NSInteger maxBytesLength;

/**
 *  中文联想，字符改变的整个字符串回调
 */
@property (nonatomic,copy) void (^textFieldChange)(DFTextField *textField, NSString *string);
/**
 *  成功输入一个字符的回调
 */
@property (nonatomic,copy) void (^inputCharacter)(DFTextField *textField, NSString *string);

/**
 *  控件状态变化的事件回调
 */
@property (nonatomic,copy) void (^notifyEvent)(DFTextField *textField, DFTextFieldEvent event);

@end

NS_ASSUME_NONNULL_END
