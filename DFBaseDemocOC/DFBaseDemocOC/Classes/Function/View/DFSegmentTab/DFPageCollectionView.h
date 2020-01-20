//
//  DFPageCollectionView.h
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/18.
//  Copyright © 2020 DF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFScrollTitleView.h"
NS_ASSUME_NONNULL_BEGIN

@class DFPageCollectionView;
@protocol DFPageCollectionViewDelegate <NSObject>

@optional
-(void)pageCollectionView:(DFPageCollectionView *)pageView selectedIndex:(NSUInteger)index;

-(void)pageCollectionView:(DFPageCollectionView *)pageView progress:(CGFloat)progress orginalIndex:(NSUInteger)orginalIndex targetIndex:(NSUInteger)targetIndex;

@end

@interface DFPageCollectionView : UIView

- (instancetype)initWithChildVCs:(NSArray *)childVCs andParentVC:(UIViewController *)parentVC;

@property (nonatomic, weak) id <DFPageCollectionViewDelegate> delegate;

- (void)setPageToCurrentIndex:(NSUInteger)currentIndex;

@end

NS_ASSUME_NONNULL_END
