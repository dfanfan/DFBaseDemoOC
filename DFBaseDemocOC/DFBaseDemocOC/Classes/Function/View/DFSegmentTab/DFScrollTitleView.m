//
//  DFScrollTitleView.m
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/18.
//  Copyright © 2020 DF. All rights reserved.
//

#import "DFScrollTitleView.h"
#import "DFItemButton.h"

@interface DFScrollTitleView ()
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) DFItemButton *lastBtn;
@property (nonatomic, weak) UIView *slideView;
@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, assign) NSUInteger currentIndex;

// 每个按钮宽度值数组
@property (nonatomic, strong) NSMutableArray *buttonsWidth;

@property (nonatomic, strong) NSMutableArray *buttonArray;

// slider的宽度和按钮宽度的offset,直接在configure里配置 (0时和按钮一样宽，>0 比按钮小， <0 比按钮大)
@property (nonatomic, assign) CGFloat sliderOffset;
// 默认3,直接在configure里配置
@property (nonatomic, assign) CGFloat sliderHeight;

@end


@implementation DFScrollTitleView

- (void)configure {
    self.margin = 18;
    self.normalFont = [UIFont systemFontOfSize:18];
//    self.selectedFont = [UIFont systemFontOfSize:18];
    self.normalColor = [UIColor blackColor];
    self.selectedColor = [UIColor blackColor];
    self.bottomLineColor = [UIColor blackColor];
    self.sliderLineColor = self.selectedColor;
    self.sliderOffset = 0;
    self.sliderHeight = 3;
    self.isAutoOverlay = YES;
}

-(instancetype)initWithTitles:(NSArray *)titles {
    self = [super init];
    if (self) {
        self.titles = titles;
        
        [self configure];
        
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.bounces = NO;
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:self.titles.count];
    for (int i = 0; i < self.titles.count; i++) {
        DFItemButton *button = [[DFItemButton alloc] init];
        button.exclusiveTouch = YES;
        button.tag = 1000 + i;
        [button setTitle:self.titles[i]];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        [self.buttonArray addObject:button];
    }
    
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = self.bottomLineColor;
    [self addSubview:lineView];
    self.lineView = lineView;
    
    UIView *slideView = [[UIView alloc] init];
    slideView.backgroundColor = self.sliderLineColor;
    [scrollView addSubview:slideView];
    self.slideView = slideView;
    
}

- (void)buttonClick:(DFItemButton *)sender {
    if (self.lastBtn == sender) {
        return;
    }
    [self p_buttonClick:sender];
    
    if ([self.delegate respondsToSelector:@selector(scrollTitleView:toIndex:)]) {
        [self.delegate scrollTitleView:self toIndex:self.currentIndex];
    }
}

- (void)p_buttonClick:(DFItemButton *)sender {
    
     self.lastBtn = sender;
     UIButton *btn = self.buttonArray[self.currentIndex];
     btn.selected = NO;
     sender.selected = YES;
     
     self.currentIndex = sender.tag - 1000;
     
     CGFloat sliderWidth = self.sliderWidth;
     CGFloat btnWidth = CGRectGetWidth(sender.bounds);
     CGFloat orginX = CGRectGetMinX(sender.frame) - (self.sliderWidth - btnWidth)/2;
     if (sliderWidth == 0) {
         sliderWidth = btnWidth + self.sliderOffset;
         orginX = CGRectGetMinX(sender.frame) - self.sliderOffset/2;
     }
    CGRect frame = CGRectMake(orginX, CGRectGetHeight(self.bounds) - self.sliderHeight, sliderWidth, self.sliderHeight);
     [UIView animateWithDuration:0.25 animations:^{
         self.slideView.frame = frame;
     }];
     
     [self scrollToCenter];
}

- (void)scrollToCenter {
    if (self.scrollView.scrollEnabled == NO) {
        return;
    }
    CGRect frame = self.slideView.frame;
    CGFloat offsetX = 0;
    CGFloat btnCenterX = frame.origin.x + frame.size.width / 2;
    // 如果选中按钮的中心点大于自身宽度的一半
    if (self.frame.size.width / 2 < btnCenterX) {
        // 如果选中按钮的中心点 + 自身宽度的一半 > contentSize.width,滚动到了最右边
        if (btnCenterX + self.frame.size.width / 2 > self.scrollView.contentSize.width) {
            offsetX = self.scrollView.contentSize.width - self.frame.size.width;
        } else {
            offsetX = btnCenterX - self.frame.size.width / 2;
        }
        
    }
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

// 计算所有按钮宽度
- (CGFloat)calculateButtonWidth {
    CGFloat totalWidth = 0;
    self.buttonsWidth = [NSMutableArray arrayWithCapacity:self.titles.count];
    for (NSString *title in self.titles) {
        UIFont *font = self.selectedFont ? self.selectedFont : self.normalFont;
        NSDictionary *attrs = @{NSFontAttributeName : font};
        CGFloat width = [title boundingRectWithSize:CGSizeMake(1000, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
        CGFloat buttonWidth = width;
        [self.buttonsWidth addObject:[NSNumber numberWithFloat:buttonWidth]];
        totalWidth += (buttonWidth+self.margin);
    }
    
    return totalWidth;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    self.scrollView.frame = frame;
    self.scrollView.scrollEnabled = YES;
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(frame) - 0.5, CGRectGetWidth(frame), 0.5);
    self.lineView.backgroundColor = self.bottomLineColor;
    
    CGFloat width = [self calculateButtonWidth];
    CGFloat space = self.margin/2;
    CGFloat lastBtnX = 0;
    self.scrollView.scrollEnabled = (width > frame.size.width);
    if (width < frame.size.width && self.isAutoOverlay) {
        // 可以布满按钮
        // 计算按钮间距
        space += (frame.size.width - width) / self.titles.count / 2;
    }
    for (NSUInteger i = 0; i < self.titles.count; i++) {
        DFItemButton *btn = self.buttonArray[i];
        CGFloat width = [self.buttonsWidth[i] floatValue];
        
        btn.normalFont = self.normalFont;
        btn.selectedFont = self.selectedFont;
        [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
//        if (i == self.currentIndex) {
//            btn.selected = YES;
//        } else {
//            btn.selected = NO;
//        }
        
        btn.frame = CGRectMake(space + lastBtnX, 0, width, frame.size.height);
        lastBtnX += (space * 2 + width);
    }
    self.scrollView.contentSize = CGSizeMake(width, frame.size.height);
    self.slideView.backgroundColor = self.sliderLineColor;
    if (CGRectGetWidth(self.slideView.bounds) == 0) {
        /// 防止第一次slideView动画重0，0的位置开始
        self.slideView.frame = CGRectMake(self.margin, CGRectGetHeight(self.bounds) - self.sliderHeight, 0, self.sliderHeight);
    }
    
    DFItemButton *btn = self.buttonArray[self.currentIndex];
    [self buttonClick:btn];
}



#pragma mark public method
- (void)setScrollTitleToIndex:(NSUInteger)index {
    if (index >= self.titles.count) {
        return;
    }
    self.currentIndex = index;
//    DFItemButton *btn = self.buttonArray[index];
//    [self buttonClick:btn];
}

- (NSUInteger)getCurrentIndex {
    return self.currentIndex;
}

// 设置圆点
- (void)setRedCircleWithIndex:(NSUInteger)index hiden:(BOOL)hiden {
    if (index >= self.titles.count) {
        return;
    }
    DFItemButton *btn = self.buttonArray[index];
    btn.redCircle = !hiden;
}

- (void)setHasSubTitle:(BOOL)hasSubTitle {
    _hasSubTitle = hasSubTitle;
    for (NSUInteger i = 0; i < self.titles.count; i++) {
        DFItemButton *btn = self.buttonArray[i];
        btn.hasSubTitle = hasSubTitle;
    }
}

- (void)setSegmentSubTitle:(NSString *)subTitle andIndex:(NSUInteger)index {
    if (index >= self.titles.count) {
        return;
    }
    DFItemButton *btn = self.buttonArray[index];
    [btn setSubTitle:subTitle];
}


/// 滚动后设置标题位置
- (void)setPageTitleViewWithProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    
    /// 没有动画
    if (progress == 1.0) {
        // 没有动画
        DFItemButton *btn = self.buttonArray[targetIndex];
        [self p_buttonClick:btn];
    }
    
}

@end
