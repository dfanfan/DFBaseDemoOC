//
//  DFPlayerView.h
//  DFPlayViewDemo
//
//  Created by dff on 2019/12/23.
//  Copyright © 2019 dff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DFPlayerPlayState) {
    DFPlayerPlayStateUnknown,
    DFPlayerPlayStatePlaying,
    DFPlayerPlayStatePaused,
    DFPlayerPlayStatePlayFailed,
    DFPlayerPlayStatePlayStopped
};


/// ZFPlayer
@interface DFPlayerView : UIView

/// 播放状态.
@property (nonatomic, assign, readonly) DFPlayerPlayState playState;

/// 当前时间
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;

/// 总时间
@property (nonatomic, assign, readonly) NSTimeInterval totalTime;

- (void)setPlayerWithUrl:(NSString *)url;

- (void)play;

- (void)stop;

- (void)replay;

- (void)pause;

/// 获取当前时刻的截图
- (UIImage *)thumbnailImageAtCurrentTime;

/// 开始播放
@property (nonatomic, copy, nullable) void(^playerReadyToPlay)(DFPlayerView *player, NSURL *assetURL);

/// 播放失败
@property (nonatomic, copy, nullable) void(^playerPlayFailed)(DFPlayerView *player, NSURL *assetURL);

/// 播放完成
@property (nonatomic, copy, nullable) void(^playerPlayComplete)(DFPlayerView *player, NSURL *assetURL);

/// 播放状态改变
@property (nonatomic, copy, nullable) void(^playerPlayStateChanged)(DFPlayerView *player, DFPlayerPlayState playState);


/// 播放进度改变
@property (nonatomic, copy, nullable) void(^playerPlayTimeChanged)(DFPlayerView *player, NSTimeInterval currentTime, NSTimeInterval duration);

/// 拖动进度
- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^ __nullable)(BOOL finished))completionHandler;



@end

NS_ASSUME_NONNULL_END
