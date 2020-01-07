//
//  UIScrollView+EmptyData.m
//  DFEmptyDataSet
//
//  Created by user on 24/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import "UIScrollView+EmptyData.h"
#import <objc/runtime.h>

@interface DFEmptyDataView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, assign) CGFloat verticalOffset;
@property (nonatomic, assign) CGFloat verticalSpace;

- (void)setupConstraints;
- (void)prepareForReuse;

@end


#pragma mark DFEmptyDataView
@implementation DFEmptyDataView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark - Getter

- (UIView *)contentView {
    
    if (!_contentView)
    {
        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = NO;
        
        [_contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:27.0];
        _titleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        
        [_contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel)
    {
        _detailLabel = [UILabel new];
        _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _detailLabel.backgroundColor = [UIColor clearColor];
        
        _detailLabel.font = [UIFont systemFontOfSize:17.0];
        _detailLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLabel.numberOfLines = 0;
        
        [_contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.backgroundColor = [UIColor clearColor];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [_button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentView addSubview:_button];
    }
    return _button;
}

- (void)setCustomView:(UIView *)customView {
    if (!customView) {
        return;
    }
    
    if (_customView) {
        [_customView removeFromSuperview];
        _customView = nil;
    }
    
    _customView = customView;
    [self.contentView addSubview:_customView];
}


- (BOOL)canShowImage
{
    return (_imageView.image && _imageView.superview);
}

- (BOOL)canShowTitle
{
    return (_titleLabel.attributedText.string.length > 0 && _titleLabel.superview);
}

- (BOOL)canShowDetail
{
    return (_detailLabel.attributedText.string.length > 0 && _detailLabel.superview);
}

- (BOOL)canShowButton
{
    if ([_button attributedTitleForState:UIControlStateNormal].string.length > 0 || [_button imageForState:UIControlStateNormal]) {
        return (_button.superview != nil);
    }
    return NO;
}


#pragma mark - Action Methods

- (void)didTapButton:(id)sender
{
    SEL selector = NSSelectorFromString(@"df_didTapDataButton:");
    
    if ([self.superview respondsToSelector:selector]) {
        [self.superview performSelector:selector withObject:sender afterDelay:0.0f];
    }
}

- (void)prepareForReuse {
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _titleLabel = nil;
    _detailLabel = nil;
    _imageView = nil;
    _button = nil;
    _customView = nil;
    
    [self removeAllConstraints];
}

- (void)removeAllConstraints
{
    [self removeConstraints:self.constraints];
    [_contentView removeConstraints:_contentView.constraints];
}


- (void)setupConstraints {
    NSLayoutConstraint *centerXConstraint = [self constant:0 withType:NSLayoutAttributeCenterX firstView:self.contentView];
    NSLayoutConstraint *centerYConstraint = [self constant:0 withType:NSLayoutAttributeCenterY firstView:self.contentView];
    NSLayoutConstraint *widthConstraint = [self constant:0 withType:NSLayoutAttributeWidth firstView:self.contentView];
    
    [self addConstraint:centerXConstraint];
    [self addConstraint:centerYConstraint];
    [self addConstraint:widthConstraint];
    
    if (self.verticalOffset != 0 && self.constraints.count > 0) {
        centerYConstraint.constant = self.verticalOffset;
    }
    
    
    if (_customView) {
        NSLayoutConstraint *centerXConstraint = [self constant:0 withType:NSLayoutAttributeCenterX firstView:_customView];
        NSLayoutConstraint *centerYConstraint = [self constant:0 withType:NSLayoutAttributeCenterY firstView:_customView];
        NSLayoutConstraint *topConstraint = [self constant:0 withType:NSLayoutAttributeTop firstView:_customView];
        NSLayoutConstraint *bottomConstraint = [self constant:0 withType:NSLayoutAttributeBottom firstView:_customView];
        [self.contentView addConstraint:centerXConstraint];
        [self.contentView addConstraint:centerYConstraint];
        [self.contentView addConstraint:topConstraint];
        [self.contentView addConstraint:bottomConstraint];

    } else {

        CGFloat width = CGRectGetWidth(self.frame) ? : CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat padding = roundf(width/16.0);
        CGFloat verticalSpace = self.verticalSpace ? : 11.0;
        if ([self canShowTitle]) {
            NSLayoutConstraint *leadingConstraint = [self constant:padding withType:NSLayoutAttributeLeading firstView:_titleLabel];
            NSLayoutConstraint *trailingConstraint = [self constant:-padding withType:NSLayoutAttributeTrailing firstView:_titleLabel];
            [self.contentView addConstraint:leadingConstraint];
            [self.contentView addConstraint:trailingConstraint];

        }
        if ([self canShowImage]) {
            NSLayoutConstraint *centerXConstraint = [self constant:0 withType:NSLayoutAttributeCenterX firstView:_imageView];
            [self.contentView addConstraint:centerXConstraint];
        }
        
        if ([self canShowDetail]) {
            NSLayoutConstraint *leadingConstraint = [self constant:padding withType:NSLayoutAttributeLeading firstView:_detailLabel];
            NSLayoutConstraint *trailingConstraint = [self constant:-padding withType:NSLayoutAttributeTrailing firstView:_detailLabel];
            [self.contentView addConstraint:leadingConstraint];
            [self.contentView addConstraint:trailingConstraint];
        }
        
        if ([self canShowButton]) {
            NSLayoutConstraint *centerXConstraint = [self constant:0 withType:NSLayoutAttributeCenterX firstView:_button];
            [self.contentView addConstraint:centerXConstraint];
        }
        UIView *preview = nil;
        for (NSUInteger i = 0; i < self.contentView.subviews.count; i++) {
            UIView *view = self.contentView.subviews[i];
            if (i == 0) {
                NSLayoutConstraint *constraint = [self constant:verticalSpace withType:NSLayoutAttributeTop firstView:view];
                [self.contentView addConstraint:constraint];
            } else {
                NSLayoutConstraint *constraint = [self constant:verticalSpace withFirstType:NSLayoutAttributeTop firstView:view andSecondType:NSLayoutAttributeBottom secondView:preview];
                [self.contentView addConstraint:constraint];

                
            }
            if (i == self.contentView.subviews.count - 1) {
                NSLayoutConstraint *constraint = [self constant:-verticalSpace withType:NSLayoutAttributeBottom firstView:view];
                [self.contentView addConstraint:constraint];

            }
            preview = view;
        }
        
    }
    
}



#pragma mark ============ NSLayoutConstraint
-(NSLayoutConstraint *)constant:(CGFloat)offset withType:(NSLayoutAttribute)attribute firstView:(UIView *)firstView secondView:(UIView *)secondView{
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    //    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    return [NSLayoutConstraint constraintWithItem:firstView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:secondView attribute:attribute multiplier:1.0 constant:offset];
}

-(NSLayoutConstraint *)constant:(CGFloat)offset withFirstType:(NSLayoutAttribute)firstAttribute firstView:(UIView *)firstView andSecondType:(NSLayoutAttribute)secondAttribute secondView:(UIView *)secondView{
    return [NSLayoutConstraint constraintWithItem:firstView attribute:firstAttribute relatedBy:NSLayoutRelationEqual toItem:secondView attribute:secondAttribute multiplier:1.0 constant:offset];
}

-(NSLayoutConstraint *)constant:(CGFloat)offset withType:(NSLayoutAttribute)attribute firstView:(UIView *)firstView{
    UIView *secondView = [firstView superview];
    return [self constant:offset withType:attribute firstView:firstView secondView:secondView];
}


@end


@interface DFWeakObjectContainer : NSObject

@property (nonatomic, readonly, weak) id weakObject;

- (instancetype)initWithWeakObject:(id)object;

@end

#pragma mark - DZNWeakObjectContainer

@implementation DFWeakObjectContainer

- (instancetype)initWithWeakObject:(id)object
{
    self = [super init];
    if (self) {
        _weakObject = object;
    }
    return self;
}

@end



#pragma mark UIScrollView+EmptyData
static char const * const kEmptyDataSetSource =     "kEmptyDataSetSource";
static char const * const kEmptyDataSetDelegate =   "kEmptyDataSetDelegate";
static char const * const kEmptyDataSetView =       "kEmptyDataSetView";

#define kEmptyImageViewAnimationKey @"com.df.emptyData.imageViewAnimation"


@interface UIScrollView () <UIGestureRecognizerDelegate>
@property (nonatomic, readonly) DFEmptyDataView *emptyDataSetView;


@end

@implementation UIScrollView (EmptyData)

#pragma mark property setter and getter
- (id<DFEmptyDataSetSource>)emptyDataSetSource {
    DFWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetSource);
    return container.weakObject;
}

- (void)setEmptyDataSetSource:(id<DFEmptyDataSetSource>)emptyDataSetSource {
    if (!emptyDataSetSource || ![self df_canDisplay]) {
        // 让代理无效
    }
    objc_setAssociatedObject(self, kEmptyDataSetSource, [[DFWeakObjectContainer alloc] initWithWeakObject:emptyDataSetSource], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self swizzleIfPossible:@selector(reloadData)];
    
    // Exclusively for UITableView, we also inject -dzn_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }
}

- (id<DFEmptyDataSetDelegate>)emptyDataSetDelegate {
    DFWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetDelegate);
    return container.weakObject;
}

- (void)setEmptyDataSetDelegate:(id<DFEmptyDataSetDelegate>)emptyDataSetDelegate {
    if (!emptyDataSetDelegate) {
//        [self dzn_invalidate];
    }
    
    objc_setAssociatedObject(self, kEmptyDataSetDelegate, [[DFWeakObjectContainer alloc] initWithWeakObject:emptyDataSetDelegate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DFEmptyDataView *)emptyDataSetView {
    DFEmptyDataView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    if (!view) {
        view = [[DFEmptyDataView alloc] init];
        
        view.hidden = YES;
//        view.backgroundColor = [UIColor redColor];
        view.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(df_didTapContentView:)];
        view.tapGesture.delegate = self;
        [view addGestureRecognizer:view.tapGesture];
        
        [self setEmptyDataSetView:view];
    }
    return view;
}

- (void)setEmptyDataSetView:(DFEmptyDataView *)emptyDataSetView {
    objc_setAssociatedObject(self, kEmptyDataSetView, emptyDataSetView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isEmptyDataSetVisible
{
    UIView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    return view ? !view.hidden : NO;
}


#pragma mark private method
/// 列表刷新时调用
- (void)df_reloadEmptyDataSet {
    if (![self df_canDisplay]) {
        return;
    }
    if ([self df_itemsCount] == 0) {
        DFEmptyDataView *view = self.emptyDataSetView;
        
        if (!view.superview) {
            if (([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) && self.subviews.count > 1) {
                [self insertSubview:view atIndex:0];
            }
            else {
                [self addSubview:view];
            }
        }
        
        view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        
        [view prepareForReuse];
        
        UIView *customView = [self df_customView];
        if (customView) {
            view.customView = customView;
        } else {
            NSAttributedString *titleLabelString = [self df_titleLabelString];
            NSAttributedString *detailLabelString = [self df_detailLabelString];
            
            UIImage *buttonImage = [self df_buttonImageForState:UIControlStateNormal];
            NSAttributedString *buttonTitle = [self df_buttonTitleForState:UIControlStateNormal];
            
            UIImage *image = [self df_image];
            
            view.verticalSpace = [self df_verticalSpace];
            
    
            if (image) {
                view.imageView.image = image;
            }
            
            if (titleLabelString) {
                view.titleLabel.attributedText = titleLabelString;
            }
            
            
            if (detailLabelString) {
                view.detailLabel.attributedText = detailLabelString;
            }
            
            if (buttonImage) {
                [view.button setImage:buttonImage forState:UIControlStateNormal];
                [view.button setImage:[self df_buttonImageForState:UIControlStateHighlighted] forState:UIControlStateNormal];
            } else if (buttonTitle) {
                [view.button setAttributedTitle:buttonTitle forState:UIControlStateNormal];
                [view.button setAttributedTitle:[self df_buttonTitleForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
                [view.button setBackgroundImage:[self df_buttonBackgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
                [view.button setBackgroundImage:[self df_buttonBackgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
            }
            
            view.verticalOffset = [self df_verticalOffset];
            view.hidden = NO;
            view.clipsToBounds = YES;
            
            view.userInteractionEnabled = [self df_isTouchAllowed];
            
            [view setupConstraints];
            
            self.scrollEnabled = NO;

            
            if ([self df_isImageViewAnimateAllowed])
            {
                CAAnimation *animation = [self df_imageAnimation];
                
                if (animation) {
                    [self.emptyDataSetView.imageView.layer addAnimation:animation forKey:kEmptyImageViewAnimationKey];
                }
            } else if ([self.emptyDataSetView.imageView.layer animationForKey:kEmptyImageViewAnimationKey]) {
                [self.emptyDataSetView.imageView.layer removeAnimationForKey:kEmptyImageViewAnimationKey];
            }

        }
        
    } else if ([self isEmptyDataSetVisible]) {
        [self df_invalidate];
    }
}


// 将空数据移除
- (void)df_invalidate {
    if (self.emptyDataSetView) {
        [self.emptyDataSetView prepareForReuse];
        [self.emptyDataSetView removeFromSuperview];
        
        [self setEmptyDataSetView:nil];
    }
    
    self.scrollEnabled = YES;
}




/// 看是否需要显示空界面
- (BOOL)df_canDisplay {
    if (self.emptyDataSetSource && [self.emptyDataSetSource conformsToProtocol:@protocol(DFEmptyDataSetSource)]) {
        if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]] || [self isKindOfClass:[UIScrollView class]]) {
            return YES;
        }
    }
    
    return NO;
}


/// 查看数据是否为空
- (NSInteger)df_itemsCount
{
    NSInteger items = 0;
    
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }

    else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    
    return items;
}


#pragma mark - Data Source Getters
- (UIView *)df_customView
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(customViewForEmptyDataSet:)]) {
        UIView *view = [self.emptyDataSetSource customViewForEmptyDataSet:self];
        if (view) NSAssert([view isKindOfClass:[UIView class]], @"You must return a valid UIView object for -customViewForEmptyDataSet:");
        return view;
    }
    return nil;
}

- (NSAttributedString *)df_titleLabelString {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(titleForEmptyDataSet:)]) {
        NSAttributedString *string = [self.emptyDataSetSource titleForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object for -titleForEmptyDataSet:");
        return string;
    }
    return nil;
}

- (NSAttributedString *)df_detailLabelString
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(descriptionForEmptyDataSet:)]) {
        NSAttributedString *string = [self.emptyDataSetSource descriptionForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object for -descriptionForEmptyDataSet:");
        return string;
    }
    return nil;
}

- (UIImage *)df_buttonImageForState:(UIControlState)state
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(buttonImageForEmptyDataSet:forState:)]) {
        UIImage *image = [self.emptyDataSetSource buttonImageForEmptyDataSet:self forState:state];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -buttonImageForEmptyDataSet:forState:");
        return image;
    }
    return nil;
}

- (UIImage *)df_buttonBackgroundImageForState:(UIControlState)state
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(buttonBackgroundImageForEmptyDataSet:forState:)]) {
        UIImage *image = [self.emptyDataSetSource buttonBackgroundImageForEmptyDataSet:self forState:state];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -buttonBackgroundImageForEmptyDataSet:forState:");
        return image;
    }
    return nil;
}

- (NSAttributedString *)df_buttonTitleForState:(UIControlState)state
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(buttonTitleForEmptyDataSet:forState:)]) {
        NSAttributedString *string = [self.emptyDataSetSource buttonTitleForEmptyDataSet:self forState:state];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object for -buttonTitleForEmptyDataSet:forState:");
        return string;
    }
    return nil;
}

- (UIImage *)df_image
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(imageForEmptyDataSet:)]) {
        UIImage *image = [self.emptyDataSetSource imageForEmptyDataSet:self];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -imageForEmptyDataSet:");
        return image;
    }
    return nil;
}


- (CGFloat)df_verticalOffset
{
    CGFloat offset = 0.0;
    
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(verticalOffsetForEmptyDataSet:)]) {
        offset = [self.emptyDataSetSource verticalOffsetForEmptyDataSet:self];
    }
    return offset;
}

- (CGFloat)df_verticalSpace
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(spaceHeightForEmptyDataSet:)]) {
        return [self.emptyDataSetSource spaceHeightForEmptyDataSet:self];
    }
    return 0.0;
}

- (BOOL)df_isTouchAllowed
{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldAllowTouch:)]) {
        return [self.emptyDataSetDelegate emptyDataSetShouldAllowTouch:self];
    }
    return YES;
}



- (BOOL)df_isImageViewAnimateAllowed
{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldAnimateImageView:)]) {
        return [self.emptyDataSetDelegate emptyDataSetShouldAnimateImageView:self];
    }
    return NO;
}

- (CAAnimation *)df_imageAnimation
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(imageAnimationForEmptyDataSet:)]) {
        CAAnimation *imageAnimation = [self.emptyDataSetSource imageAnimationForEmptyDataSet:self];
        if (imageAnimation) NSAssert([imageAnimation isKindOfClass:[CAAnimation class]], @"You must return a valid CAAnimation object for -imageAnimationForEmptyDataSet:");
        return imageAnimation;
    }
    return nil;
}




#pragma mark Method Swizzling
static NSMutableDictionary *_impLookupTable;
static NSString *const DFSwizzleInfoPointerKey = @"pointer";
static NSString *const DFSwizzleInfoOwnerKey = @"owner";
static NSString *const DFSwizzleInfoSelectorKey = @"selector";

- (void)swizzleIfPossible:(SEL)selector {
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    
    // 方法替换每个类的每个方法只执行一次。如果已经执行了直接返回
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:DFSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:DFSwizzleInfoSelectorKey];
        if ([selectorName isEqualToString:NSStringFromSelector(selector)] && [self isKindOfClass:class]) {
            return;
        }
    }
    
    // 方法替换
    Class baseClass = df_baseClassToSwizzleForTarget(self);
    NSString *key = df_implementationKey(baseClass, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:DFSwizzleInfoPointerKey];
    if (impValue || !key || !baseClass) {
        return;
    }
    
    Method method = class_getInstanceMethod(baseClass, selector);
    IMP df_newImplementation = method_setImplementation(method, (IMP)df_original_implementation);
    
    // 存储已替换的方法
    NSDictionary *swizzledInfo = @{DFSwizzleInfoOwnerKey: baseClass,
                                   DFSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   DFSwizzleInfoPointerKey: [NSValue valueWithPointer:df_newImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
    
}

void df_original_implementation(id self, SEL _cmd)
{

    Class baseClass = df_baseClassToSwizzleForTarget(self);
    NSString *key = df_implementationKey(baseClass, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:DFSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    [self df_reloadEmptyDataSet];

    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

Class df_baseClassToSwizzleForTarget(id target) {
    if ([target isKindOfClass:[UITableView class]]) {
        return [UITableView class];
    }
    else if ([target isKindOfClass:[UICollectionView class]]) {
        return [UICollectionView class];
    }
    else if ([target isKindOfClass:[UIScrollView class]]) {
        return [UIScrollView class];
    }
    return nil;
}

NSString *df_implementationKey(Class class, SEL selector)
{
    if (!class || !selector) {
        return nil;
    }
    
    NSString *className = NSStringFromClass([class class]);
    
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@",className,selectorName];

}


#pragma mark UIAction
/// 点击空页面
- (void)df_didTapContentView:(id)sender {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSet:didTapView:)]) {
        [self.emptyDataSetDelegate emptyDataSet:self didTapView:sender];
    }
}

- (void)df_didTapDataButton:(id)sender {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSet:didTapButton:)]) {
        [self.emptyDataSetDelegate emptyDataSet:self didTapButton:sender];
    }
}


#pragma mark public method
/// 手动刷新空视图
- (void)reloadEmptyDataSet {
    [self df_reloadEmptyDataSet];
}

@end
