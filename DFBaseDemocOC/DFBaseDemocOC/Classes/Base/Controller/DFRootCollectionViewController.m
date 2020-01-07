//
//  DFRootCollectionViewController.m
//  iCamdora
//
//  Created by user on 16/7/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import "DFRootCollectionViewController.h"

@interface DFRootCollectionViewController ()

@end

@implementation DFRootCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCollectionView];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewLayout = collectionViewLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    CGFloat topOffset = [self topOffset];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self hideNavView]) {
            make.top.equalTo(@(topOffset));
        }else {
            make.top.equalTo(self.navView.mas_bottom).offset(topOffset);
        }
        make.leading.trailing.bottom.equalTo(@0);
    }];
  
    
    if (@available(iOS 11.0, *))  {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}



- (CGFloat)topOffset {
    return 0;
}


#pragma mark UITableViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
