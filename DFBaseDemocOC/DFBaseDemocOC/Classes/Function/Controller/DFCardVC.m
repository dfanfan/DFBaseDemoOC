//
//  DFCardVC.m
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/10.
//  Copyright © 2020 DF. All rights reserved.
//

#import "DFCardVC.h"
#import "DFCardFlowLayout.h"
#import "DFCardOverFlowLayout.h"

#define kSectionInset 28
#define kCardWidth (kScreenWidth - kSectionInset * 2)

static NSString * const cellID = @"CCell";

@interface DFCardVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation DFCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRightButton];
    
    [self setupUI:NO];
}

- (void)addRightButton {
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"切换" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setRightButtons:@[rightBtn]];
}

- (void)clickRightBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.collectionView removeFromSuperview];
    
    [self setupUI:sender.selected];
}


- (void)setupUI:(BOOL)isSelected {
    UICollectionViewFlowLayout *layout;
    if (isSelected) {
        layout = [[DFCardFlowLayout alloc] init];
    } else {
        layout = [[DFCardOverFlowLayout alloc] init];
    }
    
    layout.itemSize = CGSizeMake(kCardWidth, kScreenHeight-200);
    layout.minimumLineSpacing = 12;
    layout.sectionInset = UIEdgeInsetsMake(0, kSectionInset, 0, kSectionInset);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    CGRect frame = CGRectMake(0, 100, kScreenWidth, kScreenHeight-100);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.decelerationRate = 0.1;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    cell.layer.cornerRadius = 10;
    return cell;
    
}


@end
