//
//  UIScrollView+EmptyData.h
//  DFEmptyDataSet
//
//  Created by user on 24/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DFEmptyDataSetSource;
@protocol DFEmptyDataSetDelegate;

@interface UIScrollView (EmptyData)

@property (nonatomic, weak) IBOutlet id<DFEmptyDataSetSource > emptyDataSetSource;

@property (nonatomic, weak) IBOutlet id<DFEmptyDataSetDelegate> emptyDataSetDelegate;

/**
 * 手动刷新空白页
 */
- (void)reloadEmptyDataSet;

@end


@protocol DFEmptyDataSetSource <NSObject>
@optional
/**
 * 空白页标题
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView;
/**
 * 空白页描述
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView;
/**
 * 空白页图片
 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView;
/**
 * 空白页图片动画
 */
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView;
/**
 * 空白页按钮标题
 */
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
/**
 * 空白页按钮图片
 */
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
/**
 * 空白页按钮背景图片
 */
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

/**
 * 返回自定义的空白页
 */
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;

/**
 * 垂直偏移
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView;

/**
 * 空白页中元素之间的空隙，默认11
 */
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView;

@end

@protocol DFEmptyDataSetDelegate <NSObject>
@optional
/**
 * 空白页userInteractionEnabled是否有效，默认YES
 */
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView;

/**
 * 默认空白页是否有动画效果
 */
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView;
/**
 * 点击空白页回调
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view;
/**
 * 点击按钮回调
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button;

@end
