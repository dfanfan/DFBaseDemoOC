//
//  DFShareUtils.h
//  DFBaseDemocOC
//
//  Created by user on 24/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFThirdPlatforms : NSObject
@property (nonatomic, copy) NSString *umAppkey;
@property (nonatomic, copy) NSString *wechatAppkey;
@property (nonatomic, copy) NSString *wechatAppSecret;
@end

@interface DFShareObject : NSObject
@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareDesc;
@property (nonatomic, copy) NSString *thumbUrl;
@property (nonatomic, copy) NSString *thumbImageName;
@end

@interface DFShareUtils : NSObject

+ (void)confitSharePlatforms;

+ (BOOL)hasPlatforms;

/// 返回app回调
+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

/// 点击分享按钮调用
+ (void)showSharePlatforms:(UIViewController *)vc object:(DFShareObject *)object complete:(void (^)(NSError *error))complete;

@end

NS_ASSUME_NONNULL_END
