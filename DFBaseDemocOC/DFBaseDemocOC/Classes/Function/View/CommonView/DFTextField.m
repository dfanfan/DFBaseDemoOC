//
//  DFTextField.m
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFTextField.h"

@implementation NSString (XXTextField)

-(BOOL)isTextFieldMatchWithRegularExpression:(NSString *)exporession {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",exporession];
    return [predicate evaluateWithObject:self];
}

-(BOOL)isTextFieldIntValue {
    return [self isTextFieldMatchWithRegularExpression:@"[-]{0,1}[0-9]*"];
}
-(BOOL)isTextFieldUnsignedIntValue {
    return [self isTextFieldMatchWithRegularExpression:@"[0-9]+"];
}
-(BOOL)isTextFieldEmoji {
    //因为emoji一直在更新，这个不行
    assert(0);
    return YES;
}
@end

@interface DFTextField ()<UITextFieldDelegate>

@end

@implementation DFTextField

- (instancetype)init {
    if (self = [super init]) {
        [self initDefault];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self initDefault];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initDefault];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initDefault {
    [self initData];
    [self setDelegate:self];
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)initData {
    _maxLength = INT_MAX;
    _maxBytesLength = INT_MAX;
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSString *text = textField.text;
    
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
    if (!position){
        //---字符处理
        if (text.length > _maxLength){
            //中文和emoj表情存在问题，需要对此进行处理
            NSRange range;
            NSUInteger inputLength = 0;
            for(int i=0; i < text.length && inputLength <= _maxLength; i += range.length) {
                range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
                inputLength += [text substringWithRange:range].length;
                if (inputLength > _maxLength) {
                    NSString* newText = [text substringWithRange:NSMakeRange(0, range.location)];
                    textField.text = newText;
                }
            }
        }
        
        //---字节处理
        //Limit
        NSUInteger textBytesLength = [textField.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (textBytesLength > _maxBytesLength) {
            NSRange range;
            NSUInteger byteLength = 0;
            for(int i=0; i < text.length && byteLength <= _maxBytesLength; i += range.length) {
                range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
                byteLength += strlen([[text substringWithRange:range] UTF8String]);
                if (byteLength > _maxBytesLength) {
                    NSString* newText = [text substringWithRange:NSMakeRange(0, range.location)];
                    textField.text = newText;
                }
            }
        }
    }
    if (self.textFieldChange) {
        self.textFieldChange(self, textField.text);
    }
}
/** 验证字符串是否符合
 *  @param string 字符串
 *  @return 是否符合
 */
- (BOOL)validateInputString:(NSString *)string textField:(UITextField *)textField {
    switch (self.inputType) {
        case DFTextFieldTypeUnsignInt:{
            return [string isTextFieldIntValue];
        }
            break;
        case DFTextFieldTypeOnlyInt:{
            return [string isTextFieldUnsignedIntValue];
        }
            break;
        case DFTextFieldTypeForbidEmoj:{
            if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]){
                return NO;
            }
        }
        default:
            break;
    }
    return YES;
}
- (void)setInputType:(DFTextFieldType)inputType {
    _inputType = inputType;
    switch (self.inputType) {
        case DFTextFieldTypeUnsignInt:
        case DFTextFieldTypeOnlyInt:
        {
            [self setKeyboardType:UIKeyboardTypeNumberPad];
        }
            break;
        default:{
            [self setKeyboardType:UIKeyboardTypeDefault];
        }
            break;
    }
}

#pragma mark- UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(self.notifyEvent){
        self.notifyEvent(self, DFTextFieldEventBegin);
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(self.notifyEvent){
        self.notifyEvent(self, DFTextFieldEventEnd);
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * inputString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if(inputString.length > 0){
        BOOL ret = [self validateInputString:inputString textField:textField];
        if (ret && self.inputCharacter) {
            self.inputCharacter(self, string);
        }
        return ret;
    }
    if (self.inputCharacter) {
        self.inputCharacter(self, string);
    }
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(self.isResignKeyboardWhenTapReturn){
        [textField resignFirstResponder];
    }
    return YES;
}

@end
