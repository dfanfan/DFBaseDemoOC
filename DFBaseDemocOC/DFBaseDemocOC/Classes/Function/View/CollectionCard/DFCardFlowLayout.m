//
//  DFCardFlowLayout.m
//  DFCardDemo
//
//  Created by dff on 2019/12/23.
//  Copyright © 2019 dff. All rights reserved.
//

#import "DFCardFlowLayout.h"

@implementation DFCardFlowLayout


- (void)prepareLayout {
    [super prepareLayout];
    
    //    NSLog(@"%f", self.itemSize.width);
    
}


/// 返回item布局对象数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self cardScaleTypeInRect:rect];
}


/// 返回值决定了collectionView停止滚动时最终的偏移量(proposedContentOffset)
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSLog(@"====velocity = %f", velocity.x);
    NSLog(@"====proposedContentOffset = %f", proposedContentOffset.x);
    
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.bounds.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    /// 最终item的中心位置
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        NSLog(@"row = %ld", attrs.indexPath.row);
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            /// 一定会跑一次赋值
            minDelta = attrs.center.x - centerX;
        }
    }
//    attrs.center.x - self.collectionView.frame.size.width * 0.5
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}

/// 如果返回YES，那么collectionView显示的范围发生改变时，就会重新刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}


//卡片缩放
- (NSArray<UICollectionViewLayoutAttributes *> *)cardScaleTypeInRect:(CGRect)rect{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    
    CGRect  visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (int i = 0; i<array.count; i++) {
        UICollectionViewLayoutAttributes *attributes = array[i];
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = fabs(distance / self.itemSize.width);
        CGFloat zoom = 1 - 0.2  * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y, attributes.size.width, attributes.size.height);
        attributes.center = CGPointMake(attributes.center.x, CGRectGetHeight(self.collectionView.frame)/2);
        
    }
    return array;
}




@end
