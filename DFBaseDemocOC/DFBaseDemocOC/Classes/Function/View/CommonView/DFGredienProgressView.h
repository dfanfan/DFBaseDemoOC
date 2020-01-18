//
//  DFGredienProgressView.h
//  DFGredientProgressView
//
//  Created by dff on 2020/1/16.
//  Copyright © 2020 dff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFGredienProgressView : UIView

@property (nonatomic, assign) CGFloat lineWidth;

/**
 更新进度
 progress (0 - 1)
 */
- (void)updateWithProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
