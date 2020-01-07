//
//  DFKeyBoardView.h
//  DFBaseDemocOC
//
//  Created by user on 23/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFKeyBoardView : UIView

@property (nonatomic, weak) UIView *keyboardBelowView;

@property (nonatomic, assign) CGFloat moveOffset;

- (void)addKeyboardNotification;


- (void)removeKeyboardNotification;

@end

NS_ASSUME_NONNULL_END
