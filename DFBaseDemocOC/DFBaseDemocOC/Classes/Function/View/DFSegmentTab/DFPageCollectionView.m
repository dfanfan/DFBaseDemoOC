//
//  DFPageCollectionView.m
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/18.
//  Copyright © 2020 DF. All rights reserved.
//

#import "DFPageCollectionView.h"
#import <Masonry/Masonry.h>

#define cellID @"cellID"


@interface DFPageCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;
@property (nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;
/// 记录刚开始时的偏移量
@property (nonatomic, assign) NSInteger startOffsetX;
/// 记录加载的上个子控制器的下标
@property (nonatomic, assign) NSInteger previousVCIndex;
/// 标记内容滚动
@property (nonatomic, assign) BOOL isScroll;
@end

@implementation DFPageCollectionView

- (instancetype)initWithChildVCs:(NSArray *)childVCs andParentVC:(UIViewController *)parentVC {
    self = [super init];
    if (self) {
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        [self commonInit];
        [self setupUI];
    }
    return self;
}

- (void)commonInit {
    for (UIViewController *childVC in self.childVCs) {
        if (self.parentVC) {
            [self.parentVC addChildViewController:childVC];
        }
    }
}

- (void)setupUI {
    [self addSubview:self.collectionView];
    
    /// 解决隐藏导航栏返回手势失效的问题
    NSArray *gestureArray = self.parentVC.navigationController.view.gestureRecognizers;
    for (UIGestureRecognizer *gestureRecognizer in gestureArray) {
        if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [self.collectionView.panGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
        }
        
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _collectionViewLayout.itemSize = self.frame.size;
    _collectionView.frame = self.bounds;
    CGFloat offsetX = self.previousVCIndex * self.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}


#pragma mark - getter --- setter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.bounces = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewLayout {
    if (_collectionViewLayout == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionViewLayout = layout;
    }
    
    return _collectionViewLayout;
}


#pragma mark UICollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 设置内容
    UIViewController *childVC = self.childVCs[indexPath.item];
    [self.parentVC addChildViewController:childVC];
    [cell.contentView addSubview:childVC.view];
    childVC.view.frame = cell.contentView.frame;
    [childVC didMoveToParentViewController:self.parentVC];
    return cell;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _startOffsetX = scrollView.contentOffset.x;
    _isScroll = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        _isScroll = NO;
        NSUInteger index = scrollView.contentOffset.x / self.bounds.size.width;
        _previousVCIndex = index;

        if (self.delegate && [self.delegate respondsToSelector:@selector(pageCollectionView:selectedIndex:)]) {
            [self.delegate pageCollectionView:self selectedIndex:index];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isScroll = NO;
    NSUInteger index = scrollView.contentOffset.x / self.bounds.size.width;
    _previousVCIndex = index;

    if (self.delegate && [self.delegate respondsToSelector:@selector(pageCollectionView:selectedIndex:)]) {
        [self.delegate pageCollectionView:self selectedIndex:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_isScroll == NO) {
        return;
    }
    // 1、定义获取需要的数据
    CGFloat progress = 0;
    NSInteger originalIndex = 0;
    NSInteger targetIndex = 0;
    // 2、判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > _startOffsetX) { // 左滑
        // 1、计算 progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        // 2、计算 originalIndex
        originalIndex = currentOffsetX / scrollViewW;
        // 3、计算 targetIndex
        targetIndex = originalIndex + 1;
        if (targetIndex >= self.childVCs.count) {
            progress = 1;
            targetIndex = originalIndex;
        }
        // 4、如果完全划过去
        if (currentOffsetX - _startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = originalIndex;
        }
    } else { // 右滑
        // 1、计算 progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        // 2、计算 targetIndex
        targetIndex = currentOffsetX / scrollViewW;
        // 3、计算 originalIndex
        originalIndex = targetIndex + 1;
        if (originalIndex >= self.childVCs.count) {
            originalIndex = self.childVCs.count - 1;
        }
    }
    // 3、pageContentCollectionViewDelegate; 将 progress／sourceIndex／targetIndex 传递给 SGPageTitleView
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageCollectionView:progress:orginalIndex:targetIndex:)]) {
        [self.delegate pageCollectionView:self progress:progress orginalIndex:originalIndex targetIndex:targetIndex];
    }
}



- (void)setPageToCurrentIndex:(NSUInteger)currentIndex {
    CGFloat offsetX = currentIndex * self.collectionView.bounds.size.width;
    _startOffsetX = offsetX;
    // 1、处理内容偏移
    if (_previousVCIndex != currentIndex) {
        [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    }
    // 2、记录上个子控制器下标
    _previousVCIndex = currentIndex;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageCollectionView:selectedIndex:)]) {
        [self.delegate pageCollectionView:self selectedIndex:currentIndex];
    }
}

@end
