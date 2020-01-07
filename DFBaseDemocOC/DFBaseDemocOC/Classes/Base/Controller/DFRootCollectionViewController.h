//
//  DFRootCollectionViewController.h
//  iCamdora
//
//  Created by user on 16/7/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import "DFRootViewController.h"
//#import "UICollectionView+List.h"


@interface DFRootCollectionViewController : DFRootViewController<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, weak) UICollectionView *collectionView;


/// 子类可以重写该方法来设置tableview距离导航栏的距离(默认0)
- (CGFloat)topOffset;

@end
