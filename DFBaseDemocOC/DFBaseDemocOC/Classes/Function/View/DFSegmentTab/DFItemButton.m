//
//  DFItemButton.m
//  Test1
//
//  Created by user on 7/7/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import "DFItemButton.h"


@interface DFItemButton ()
@property (nonatomic, strong) UIView *redCircleView;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, weak) UILabel *titleLabel;

// 普通颜色
@property (nonatomic, strong) UIColor *normalColor;
// 选中颜色
@property (nonatomic, strong) UIColor *selectedColor;
@end

@implementation DFItemButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.backgroundColor = [UIColor whiteColor];
//    titleLabel.layer.masksToBounds = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (UIView *)redCircleView {
    if (!_redCircleView) {
        _redCircleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        _redCircleView.hidden = YES;
        _redCircleView.backgroundColor = [UIColor colorWithRed:255.0/255 green:77.0/255 blue:70.0/255 alpha:1.0];
        [self addSubview:_redCircleView];
        
        _redCircleView.layer.cornerRadius = 4;
        _redCircleView.layer.masksToBounds = YES;
    }
    return _redCircleView;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
//        _subTitleLabel.backgroundColor = [UIColor whiteColor];
//        _subTitleLabel.layer.masksToBounds = YES;
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if (self.hasSubTitle) {
        CGPoint center = CGPointMake(width/2.0, height/2.0 - 5);
        self.titleLabel.center = center;
        center.y += 20;
//        self.subTitleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 15);
        self.subTitleLabel.center = center;
        [self.subTitleLabel sizeToFit];
    } else {
        self.titleLabel.center = CGPointMake(width/2.0, height/2.0);
    }
    [self.titleLabel sizeToFit];
    if (self.redCircle) {
        [self updateCircleViewFrame];
    }
    
}

- (void)updateCircleViewFrame {
    self.redCircleView.hidden = NO;
    CGRect frame = self.redCircleView.frame;
    frame.origin.x = self.bounds.size.width - 10;
    frame.origin.y = self.bounds.size.height/2 - 15;
    self.redCircleView.frame = frame;
}

- (void)updateTitleFont {
    if (_selectedFont) {
        self.titleLabel.font = self.isSelected ? self.selectedFont : self.normalFont;
        [self.titleLabel sizeToFit];
    } else {
        self.titleLabel.font = self.normalFont;
    }
}


#pragma mark public method
- (void)setHasSubTitle:(BOOL)hasSubTitle {
    _hasSubTitle = hasSubTitle;
    if (hasSubTitle) {
        self.subTitleLabel.hidden = NO;
    }
}

- (void)setRedCircle:(BOOL)redCircle {
    _redCircle = redCircle;
    if (redCircle) {
        [self updateCircleViewFrame];
    } else {
        [_redCircleView removeFromSuperview];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.titleLabel.textColor = selected ? self.selectedColor : self.normalColor;
    _subTitleLabel.textColor = selected ? self.selectedColor : self.normalColor;
    [self updateTitleFont];
}

- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        self.normalColor = color;
    } else if (state == UIControlStateSelected) {
        self.selectedColor = color;
    }
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}


- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;

}

- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
    [self updateTitleFont];
}

- (void)setSubTitle:(NSString *)title {
    _subTitleLabel.text = title;
    [self updateTitleFont];
}

- (void)setSubTitleFont:(nullable UIFont *)font {
    _subTitleLabel.font = font;
}




@end
