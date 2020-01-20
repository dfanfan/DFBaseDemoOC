//
//  DFSegmentTabView.h
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/18.
//  Copyright © 2020 DF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFScrollTitleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFSegmentTabView : UIView

- (instancetype)initWithTitles:(NSArray *)titles childVCs:(NSArray *)childVCs andParentVC:(UIViewController *)parentVC;

@property (nonatomic, weak) DFScrollTitleView *titleView;

- (void)setTitleViewHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
