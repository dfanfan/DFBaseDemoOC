//
//  DFCardOverFlowLayout.m
//  DFCardDemo
//
//  Created by dff on 2020/1/7.
//  Copyright © 2020 dff. All rights reserved.
//

#import "DFCardOverFlowLayout.h"

#define kOverNum 2
#define kMargin 8

@interface DFCardOverFlowLayout ()
@property(nonatomic,assign)CGPoint collectionContenOffset;
@property(nonatomic,assign)CGSize collectionContenSize;

@property (nonatomic, assign) CGPoint lastContentOffset;
@end

@implementation DFCardOverFlowLayout


- (void)prepareLayout {
    [super prepareLayout];

}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    
    if(ABS(proposedContentOffset.x - self.lastContentOffset.x) >= self.collectionView.frame.size.width * 0.5) {
        
        if (velocity.x > 0) {
            proposedContentOffset.x = self.lastContentOffset.x + self.itemSize.width + self.minimumLineSpacing;
        } else {
            proposedContentOffset.x = self.lastContentOffset.x - (self.itemSize.width + self.minimumLineSpacing);
        }
    
    } else {
        proposedContentOffset = self.lastContentOffset;
    }

    self.lastContentOffset = proposedContentOffset;
    return proposedContentOffset;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self cardOverLapTypeInRect:rect];
}

////卡片重叠
- (NSArray<UICollectionViewLayoutAttributes *> *)cardOverLapTypeInRect:(CGRect)rect{
    
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    if (itemsCount <= 0) {
        return nil;
    }
    
    
    NSInteger currentPath = MAX(floor(self.collectionContenOffset.x / self.collectionContenSize.width), 0);
    NSUInteger minVisibleIndex = MAX(currentPath-1, 0);
    NSUInteger maxVisibleIndex = MAX(MIN(itemsCount - 1, currentPath + kOverNum), minVisibleIndex);
    
    /// 滚动进度
    CGFloat offsetProgress = 1 - ((int)self.collectionContenOffset.x % (int)self.collectionContenSize.width) / self.collectionContenSize.width;
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    
    CGFloat marginOffset = self.sectionInset.left - kMargin;
    
    for (NSUInteger i = minVisibleIndex; i<=maxVisibleIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [[self layoutAttributesForItemAtIndexPath:indexPath] copy];

        if (i < currentPath) {
            attributes.transform3D = CATransform3DIdentity;
            attributes.zIndex = 400;
        }else if (i == currentPath) {
            
            attributes.transform3D = CATransform3DIdentity;
            attributes.zIndex = 300;
        } else if (i == currentPath + 1) {
            /// 如果是底部的
            attributes.transform3D = CATransform3DMakeTranslation(-(self.collectionContenSize.width - marginOffset) * offsetProgress, -offsetProgress * marginOffset, 0.0);
            attributes.zIndex = 200;
        } else {
            attributes.transform3D = CATransform3DMakeTranslation(-(2*self.collectionContenSize.width - marginOffset) +  (1-offsetProgress) * self.collectionContenSize.width, -marginOffset, 0.0);
            attributes.zIndex = 100;
        }
        
        NSLog(@"%ld, %ld", indexPath.row, attributes.zIndex);
        
        [mArr addObject:attributes];
    }
    return mArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}



- (CGSize)collectionContenSize{
    return CGSizeMake((int)self.itemSize.width + self.minimumLineSpacing, (int)self.collectionView.bounds.size.height);
}

- (CGPoint)collectionContenOffset{
    return CGPointMake((int)self.collectionView.contentOffset.x, (int)self.collectionView.contentOffset.y);
}

@end
