//
//  DFScrollTitleView.h
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/18.
//  Copyright © 2020 DF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DFScrollTitleView;

@protocol DFScrollTitleViewDelegate <NSObject>
@optional
-(void)scrollTitleView:(DFScrollTitleView *)titleView toIndex:(NSUInteger)index;

@end

@interface DFScrollTitleView : UIView

// 普通字体大小
@property (nonatomic, strong) UIFont *normalFont;
// 选中字体大小
@property (nonatomic, strong) UIFont *selectedFont;
// 普通颜色
@property (nonatomic, strong) UIColor *normalColor;
// 选中颜色
@property (nonatomic, strong) UIColor *selectedColor;
// 底部线颜色
@property (nonatomic, strong) UIColor *bottomLineColor;
// slider线颜色
@property (nonatomic, strong) UIColor *sliderLineColor;
// slider线宽度（不设置会默认按照按钮的宽度去给）
@property (nonatomic, assign) CGFloat sliderWidth;
// 字体间距
@property (nonatomic, assign) CGFloat margin;
// 是否自动铺满(YES时 margin可能失效) 默认yes
@property (nonatomic, assign) BOOL isAutoOverlay;

// 是否有副标题
@property (nonatomic, assign) BOOL hasSubTitle;

@property (nonatomic, weak) id <DFScrollTitleViewDelegate> delegate;
- (instancetype)initWithTitles:(NSArray *)titles;
/// 初始化后设置选中第几个，默认选中第0个不需要调用该方法
- (void)setScrollTitleToIndex:(NSUInteger)index;

- (NSUInteger)getCurrentIndex;

/// 滚动后设置标题位置
- (void)setPageTitleViewWithProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;



// 设置圆点
- (void)setRedCircleWithIndex:(NSUInteger)index hiden:(BOOL)hiden;
- (void)setSegmentSubTitle:(NSString *)subTitle andIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
