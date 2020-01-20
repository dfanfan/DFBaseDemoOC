//
//  DFSegmentTabView.m
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/18.
//  Copyright © 2020 DF. All rights reserved.
//

#import "DFSegmentTabView.h"
#import <Masonry/Masonry.h>
#import "DFPageCollectionView.h"

@interface DFSegmentTabView ()<DFScrollTitleViewDelegate, DFPageCollectionViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, weak) UIViewController *parentVC;


@property (nonatomic, weak) DFPageCollectionView *pageView;

@end

@implementation DFSegmentTabView

- (instancetype)initWithTitles:(NSArray *)titles childVCs:(NSArray *)childVCs andParentVC:(UIViewController *)parentVC {
    self = [super init];
    if (self) {
        self.titles = titles;
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    DFScrollTitleView *titleView = [[DFScrollTitleView alloc] initWithTitles:self.titles];
    titleView.delegate = self;
    [self addSubview:titleView];
    self.titleView = titleView;
    
    DFPageCollectionView *pageView = [[DFPageCollectionView alloc] initWithChildVCs:self.childVCs andParentVC:self.parentVC];
    pageView.delegate = self;
    [self addSubview:pageView];
    self.pageView = pageView;
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(@0);
        make.height.equalTo(@50);
    }];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom);
        make.leading.trailing.bottom.equalTo(@0);
    }];
}


#pragma mark delegate
-(void)scrollTitleView:(DFScrollTitleView *)titleView toIndex:(NSUInteger)index {
    [self.pageView setPageToCurrentIndex:index];
}

-(void)pageCollectionView:(DFPageCollectionView *)pageView selectedIndex:(NSUInteger)index {

    
}

-(void)pageCollectionView:(DFPageCollectionView *)pageView progress:(CGFloat)progress orginalIndex:(NSUInteger)orginalIndex targetIndex:(NSUInteger)targetIndex {

    [self.titleView setPageTitleViewWithProgress:progress originalIndex:orginalIndex targetIndex:targetIndex];
}


#pragma mark public method
- (void)setTitleViewHeight:(CGFloat)height {
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}


@end
