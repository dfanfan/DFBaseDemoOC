//
//  DFShareUtils.m
//  DFBaseDemocOC
//
//  Created by user on 24/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "DFShareUtils.h"
#import <UMCommon/UMCommon.h>
#import <UShareUI/UShareUI.h>

@implementation DFThirdPlatforms
- (instancetype)init {
    self = [super init];
    if (self) {
        self.umAppkey = @"5a53225db27b0a65890000fc";
        self.wechatAppkey = @"wx341729bdc2271abb";
        self.wechatAppSecret = @"9ead71530caf7d8a6931345c095fe483";
    }
    return self;
}
@end

@implementation DFShareObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shareTitle = @"全景拍房";
        self.shareDesc = @"全景拍房为您推荐了一套绝世好房";
        self.thumbImageName = @"comm_icon";
    }
    return self;
}
@end

@implementation DFShareUtils

+ (void)confitSharePlatforms {
    /* 打开调试日志 */
#ifdef DEBUG
    [[UMSocialManager defaultManager] openLog:YES];
#endif
    DFThirdPlatforms *thirdPlatform = [[DFThirdPlatforms alloc] init];
    /* 设置友盟appkey */
    [UMConfigure initWithAppkey:thirdPlatform.umAppkey channel:@"app store"];
    
    
    //微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:thirdPlatform.wechatAppkey appSecret:thirdPlatform.wechatAppSecret redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
}

+ (BOOL)hasPlatforms {
    return [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
}

/// 返回app回调
/// iOS9以下系统
+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}
/// ios9以上系统
+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [[UMSocialManager defaultManager] handleOpenURL:url options:options];
}

+ (void)showSharePlatforms:(UIViewController *)vc object:(DFShareObject *)object complete:(void (^)(NSError *error))complete {
    __weak typeof(vc) weakVC = vc;
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        NSLog(@"%@", userInfo);
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        id thumImage = nil;
        if (object.thumbUrl.length > 0) {
            thumImage = object.thumbUrl;
        } else if (object.thumbImageName.length > 0) {
            thumImage = [UIImage imageNamed:object.thumbImageName];
        }
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:object.shareTitle descr:object.shareDesc thumImage:thumImage];
        //设置网页地址
        shareObject.webpageUrl = object.webUrl;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:weakVC completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            if (complete) {
                complete(error);
            }
        }];
        
    }];
}

@end
