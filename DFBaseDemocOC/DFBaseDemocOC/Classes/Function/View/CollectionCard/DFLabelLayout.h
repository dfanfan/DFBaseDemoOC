//
//  DFLabelLayout.h
//  DFLabelTag
//
//  Created by user on 11/2/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  DFLabelLayoutDelegate<UICollectionViewDelegateFlowLayout>
@end

@interface DFLabelLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<DFLabelLayoutDelegate> delegate;

@end
