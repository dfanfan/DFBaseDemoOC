//
//  DFSegmentTabVC.m
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/19.
//  Copyright © 2020 DF. All rights reserved.
//

#import "DFSegmentTabVC.h"
#import "DFSegmentTabView.h"

@interface DFSegmentTabVC ()

@end

@implementation DFSegmentTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    NSArray *titles = @[@"one", @"two", @"three", @"forth"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSString *title in titles) {
        DFRootViewController *vc = [[DFRootViewController alloc] init];
        [arr addObject:vc];
    }
    DFSegmentTabView *tabView = [[DFSegmentTabView alloc] initWithTitles:titles childVCs:arr andParentVC:self];
    tabView.titleView.selectedColor = [UIColor orangeColor];
    tabView.titleView.selectedFont = [UIFont systemFontOfSize:22];
//    [tabView.titleView setScrollTitleToIndex:2];
    [self.view addSubview:tabView];
    
    [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(@0);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(0);
    }];
}


@end
