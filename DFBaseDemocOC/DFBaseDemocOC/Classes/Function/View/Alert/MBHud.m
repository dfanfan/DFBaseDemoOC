//
//  MBHud.m
//  DFBaseDemocOC
//
//  Created by user on 16/7/19.
//  Copyright © 2019年 DF. All rights reserved.
//

#import "MBHud.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#import "DFLoadingView.h"

static const void *objHUDKey = &objHUDKey;
#define SHOW_TIME 1.5

@implementation MBHud

+ (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, objHUDKey);
}

+ (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, objHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (MBProgressHUD *)createHudWithView:(nullable UIView *)view andMask:(BOOL) isMask{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [self HUD];
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:view];
        hud.bezelView.color = [UIColor colorWithRed:229.0/255 green:233.0/255 blue:242.0/255 alpha:1.0];
        hud.contentColor = [UIColor colorWithRed:71.0/255 green:86.0/255 blue:105.0/255 alpha:1.0];
        [view addSubview:hud];
        hud.animationType = MBProgressHUDAnimationZoom;
    }
    if (isMask) {
        hud.backgroundView.color = [UIColor colorWithWhite:0 alpha:0.45];
    }else{
        hud.backgroundView.color = [UIColor clearColor];
    }
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    return hud;
}

//自定义view显示
+ (void)show:(nullable NSString *)text icon:(nullable NSString *)icon view:(nullable UIView *)view completionBlock:(nullable void (^)(void))completion{
    MBProgressHUD *hud = [self createHudWithView:view andMask:YES];
    
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    //    hud.removeFromSuperViewOnHide = YES;
    //    [hud showAnimated:YES];
    // 1.5秒之后再消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, SHOW_TIME*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [hud hideAnimated:NO];
        [self setHUD:nil];
        if (completion) {
            completion();
        }
    });
}

//显示加载
+ (void)showHudInView:(nullable UIView *)view{
    [self showHudInView:view andMask:NO];
}

//加载是否遮盖
+ (void)showHudInView:(nullable UIView *)view andMask:(BOOL) isMask{
    MBProgressHUD *hud = [self createHudWithView:view andMask:isMask];
    hud.mode = MBProgressHUDModeIndeterminate;
    [self setHUD:hud];
}

//显示提示语
+ (void)showHudInView:(nullable UIView *)view hint:(nullable NSString *)hint{
    [self showHudInView:view hint:hint andMask:NO];
}

//显示提示语是否遮盖
+ (void)showHudInView:(UIView *)view hint:(nullable NSString *)hint andMask:(BOOL) isMask{
    
    MBProgressHUD *hud = [self createHudWithView:view andMask:isMask];
    hud.mode = MBProgressHUDModeText;
    
    hud.detailsLabel.font = [UIFont systemFontOfSize:16.0];
    hud.detailsLabel.text = hint;
    
    [self setHUD:nil];
    [hud hideAnimated:YES afterDelay:SHOW_TIME];
    
}


//成功后提示
+ (void)showSuccessWithHint:(nullable NSString*)hint andView:(nullable UIView *)view success:(nullable void (^)(void))success{
    [self show:hint icon:@"success" view:view completionBlock:success];
}


//失败后提示
+ (void)showErrorWithHint:(nullable NSString *)hint andView:(nullable UIView *)view{
    [self show:hint icon:@"failed" view:view completionBlock:nil];
}

//进度是否遮盖
+ (void)showHudInView:(nullable UIView *)view progress:(float)progress andMask:(BOOL) isMask{
    MBProgressHUD *hud = [self createHudWithView:view andMask:isMask];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.contentColor = [UIColor yellowColor];
    hud.progress = progress;
    [self setHUD:hud];
    if (progress >= 1) {
        [hud hideAnimated:YES];
    }
}

//隐藏
+ (void)hideHud{
    MBProgressHUD *hud = [self HUD];
    if (!hud) {
        return;
    }
    [hud hideAnimated:YES];
    [self setHUD:nil];
    [NSThread sleepForTimeInterval:0.1];
}



//显示加载提示和是否遮盖
+ (void)showLoadingView:(nullable UIView *)view hint:(nullable NSString *)hint andMask:(BOOL) isMask {
    MBProgressHUD *hud = [self createHudWithView:view andMask:isMask];
    
    hud.label.text = hint;
    hud.label.numberOfLines = 0;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
//     设置图片
    DFLoadingView *customView = [[DFLoadingView alloc] init];
    hud.customView = customView;
    
    [self setHUD:hud];
}

@end
