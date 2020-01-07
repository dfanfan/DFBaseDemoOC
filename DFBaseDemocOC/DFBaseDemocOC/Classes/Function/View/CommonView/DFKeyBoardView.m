//
//  DFKeyBoardView.m
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFKeyBoardView.h"

@implementation DFKeyBoardView

- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWassShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//键盘出现和隐藏，改变view的frame
-(void)keyboardWassShown:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    if (self.keyboardBelowView) {
        CGRect tempFrame = [self appearViewConvertToWindowFrame:self.keyboardBelowView];
        if (keyboardRect.origin.y < CGRectGetMaxY(tempFrame)) {
            CGFloat space = CGRectGetMaxY(tempFrame) - keyboardRect.origin.y + self.moveOffset;
            
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeTranslation(0, -space);
            }];
        }
        return;
    }
    
    CGFloat space = self.moveOffset;
    if (self.moveOffset == 0) {
        space += keyboardRect.size.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -space);
    }];
}

-(CGRect)appearViewConvertToWindowFrame:(UIView *)view{
    NSLog(@"%f", view.frame.origin.y);
    if (!view.superview) {
        // 没有父视图直接返回自己的frame
        return view.frame;
    }
    CGRect frame = [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
    return frame;
}

-(void)keyboardWillBeHidden:(NSNotification *)noti{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)dealloc {
    NSLog(@"DFKeyBoardView dealloc");
}

@end
