//
//  DFPlayerView.m
//  DFPlayViewDemo
//
//  Created by dff on 2019/12/23.
//  Copyright © 2019 dff. All rights reserved.
//

#import "DFPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface DFPlayerView ()<AVAssetResourceLoaderDelegate>
@property (nonatomic, strong) NSURL *sourceUrl;
@property (nonatomic, strong) AVURLAsset *urlAsset;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) id timeObserver;      //视频播放器周期性调用的观察者

@property (nonatomic) NSTimeInterval seekTime;

@property (nonatomic, assign) BOOL isPrepared;
@property (nonatomic, assign) BOOL isPlaying;



@end

@implementation DFPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.player = [[AVPlayer alloc] init];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:self.playerLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
    _playerLayer.frame = self.layer.bounds;
//    [CATransaction commit];
}




- (void)setPlayerWithUrl:(NSString *)url {
    self.isPrepared = NO;
    self.sourceUrl = [NSURL URLWithString:url];
    
    self.urlAsset = [AVURLAsset URLAssetWithURL:self.sourceUrl options:nil];
    
    [self.urlAsset.resourceLoader setDelegate:self queue:dispatch_get_main_queue()];
    
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    self.playerLayer.player = self.player;
    
    if (@available(iOS 9.0, *)) {
        self.playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = NO;
    }
    if (@available(iOS 10.0, *)) {
        self.playerItem.preferredForwardBufferDuration = 5;
        self.player.automaticallyWaitsToMinimizeStalling = NO;
    }
    
    [self addProgressObserver];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //AVPlayerItem.status
    NSLog(@"_playerItem status = %ld", _playerItem.status);

    if([keyPath isEqualToString:@"status"]) {
        //视频源装备完毕，则显示playerLayer
        if(_playerItem.status == AVPlayerItemStatusReadyToPlay) {
            if (self.isPrepared == NO) {
                if (self.playerReadyToPlay) {
                    self.playerReadyToPlay(self, self.sourceUrl);
                }
                
            }
            self.isPrepared = YES;
            
            if (self.isPlaying) {
                [self play];
            }
            
            NSLog(@"AVPlayerItemStatusReadyToPlay");
        } else if (_playerItem.status == AVPlayerItemStatusFailed) {
            self.playState = DFPlayerPlayStatePlayFailed;
            self.isPlaying = NO;
            if (self.playerPlayFailed) {
                self.playerPlayFailed(self, self.sourceUrl);
            }
        }
        //视频播放状体更新方法回调
//        if(self.delegate) {
//            [self.delegate onPlayItemStatusUpdate:_playerItem.status];
//        }
    }
}

- (void)addProgressObserver {
    __weak typeof(self) weakSelf = self;
    
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {

        if(weakSelf.playerItem.status == AVPlayerItemStatusReadyToPlay) {
            //获取当前播放时间
            float current = CMTimeGetSeconds(time);
            //获取视频播放总时间
            float total = CMTimeGetSeconds([weakSelf.playerItem duration]);
            //重新播放视频
            if(total == current) {
                [weakSelf replay];
                if (weakSelf.playerPlayComplete) {
                    weakSelf.playerPlayComplete(weakSelf, weakSelf.sourceUrl);
                }
            }
            //更新视频播放进度方法回调
            if(weakSelf.playerPlayTimeChanged) {
                weakSelf.playerPlayTimeChanged(weakSelf, current, total);
            }
            
        }
    }];
}

- (void)dealloc {
    NSLog(@"player dealloc");
    [self removeObserver];
}

- (void)removeObserver {
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.player removeTimeObserver:self.timeObserver];
}

- (void)play {
    self.isPlaying = YES;
    if (!self.isPrepared) {
        
    } else {
        [self.player play];
        self.playState = DFPlayerPlayStatePlaying;
    }
    
    NSLog(@"play");

}

- (void)stop {
    self.isPlaying = NO;
    [self.player pause];
    [self.playerItem cancelPendingSeeks];
    [self.urlAsset cancelLoading];
    self.playState = DFPlayerPlayStatePlayStopped;
}

- (void)replay {
    
    __weak typeof(self) weakSelf = self;

    [self seekToTime:0 completionHandler:^(BOOL finished) {
        [weakSelf play];
    }];

}

- (void)pause {
    self.isPlaying = NO;
    [self.player pause];
    [self.playerItem cancelPendingSeeks];
    [self.urlAsset cancelLoading];
    self.playState = DFPlayerPlayStatePaused;
}


- (UIImage *)thumbnailImageAtCurrentTime {
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:self.urlAsset];
    CMTime expectedTime = _playerItem.currentTime;
    CGImageRef cgImage = NULL;
    
    imageGenerator.requestedTimeToleranceBefore = kCMTimeZero;
    imageGenerator.requestedTimeToleranceAfter = kCMTimeZero;
    cgImage = [imageGenerator copyCGImageAtTime:expectedTime actualTime:NULL error:NULL];
    
    if (!cgImage) {
        imageGenerator.requestedTimeToleranceBefore = kCMTimePositiveInfinity;
        imageGenerator.requestedTimeToleranceAfter = kCMTimePositiveInfinity;
        cgImage = [imageGenerator copyCGImageAtTime:expectedTime actualTime:NULL error:NULL];
    }
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    return image;
}


- (NSTimeInterval)totalTime {
    NSTimeInterval sec = CMTimeGetSeconds(self.player.currentItem.duration);
    if (isnan(sec)) {
        return 0;
    }
    return sec;
}


/// 拖动进度
- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^ __nullable)(BOOL finished))completionHandler {
    if (self.totalTime > 0) {
        CMTime seekTime = CMTimeMake(time, 1);
        [_player seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:completionHandler];
    } else {
        self.seekTime = time;
    }
}

- (void)setPlayState:(DFPlayerPlayState)playState {
    _playState = playState;
    if (self.playerPlayStateChanged) {
        self.playerPlayStateChanged(self, playState);
    }
}

@end
