//
//  DFPlayerVC.m
//  DFBaseDemocOC
//
//  Created by dff on 2020/1/15.
//  Copyright © 2020 DF. All rights reserved.
//

#import "DFPlayerVC.h"
#import "DFListCell.h"
#import "DFVideoModel.h"
#import "DFPlayerView.h"
#import "DFPlayerView.h"


static NSString  * const cellID = @"cellID";

@interface DFPlayerVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) DFPlayerView *player;

@property (nonatomic, assign) NSInteger currentIndex;


@end

@implementation DFPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupData];
}

- (void)setupUI {
    self.tableView.rowHeight = kScreenWidth * 9 / 16;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DFListCell" bundle:nil] forCellReuseIdentifier:cellID];
}

- (void)setupData {
    NSArray *videoUrls = @[@"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4",
                           @"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4",
                           @"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4",
                           @"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4",
                           @"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4",
                           @"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4",
                           @"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4",
                           @"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4",
                           @"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4",
                           @"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4",
                           @"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4",
                           @"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4",
                           @"http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8",
                           @"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4"
    ];
    NSArray *coverUrls = @[@"1", @"1", @"1", @"1",@"1", @"1", @"1", @"1",@"1", @"1", @"1", @"1",@"1", @"1", @"1", @"1",@"1", @"1", @"1", @"1"];
    NSArray *names = @[@"精灵旅社", @"麻辣变形计", @"男友宁愿找闺蜜", @"微微一笑很倾城", @"精灵旅社", @"麻辣变形计", @"男友宁愿找闺蜜", @"微微一笑很倾城", @"精灵旅社", @"麻辣变形计", @"男友宁愿找闺蜜", @"微微一笑很倾城", @"精灵旅社", @"麻辣变形计", @"男友宁愿找闺蜜", @"微微一笑很倾城"];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:2];
    
    for (NSUInteger i = 0; i < videoUrls.count; i++) {
        DFVideoModel *model = [[DFVideoModel alloc] init];
        model.name = names[i];
        model.videoUrl = videoUrls[i];
        model.coverUrl = coverUrls[i];
        [self.dataArray addObject:model];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DFListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    //    [self toPlayerVC:indexPath.row];
    [self beginPlay];
}


- (void)beginPlay {
    [self.view addSubview:self.player];
    DFVideoModel *model = self.dataArray[self.currentIndex];
    [self.player setPlayerWithUrl:model.videoUrl];
    
    [self.player play];
    
}

- (void)playerViewTap {
    [self.player stop];
    [self.player removeFromSuperview];
}


- (DFPlayerView *)player {
    if (!_player) {
        _player = [[DFPlayerView alloc] initWithFrame:self.view.bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playerViewTap)];
        [_player addGestureRecognizer:tap];
        _player.playerPlayComplete = ^(DFPlayerView * _Nonnull player, NSURL * _Nonnull assetURL) {
            NSLog(@"=== playerPlayComplete");
        };
        
        _player.playerReadyToPlay = ^(DFPlayerView * _Nonnull player, NSURL * _Nonnull assetURL) {
            NSLog(@"=== playerReadyToPlay");
        };
        
        _player.playerPlayFailed = ^(DFPlayerView * _Nonnull player, NSURL * _Nonnull assetURL) {
            NSLog(@"=== playerPlayFailed");
        };
        
        _player.playerPlayTimeChanged = ^(DFPlayerView * _Nonnull player, NSTimeInterval currentTime, NSTimeInterval duration) {
            NSLog(@"=== playerPlayTimeChanged");
        };
    }
    return _player;
}



@end
