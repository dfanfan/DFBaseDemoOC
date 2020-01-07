//
//  AppDelegate.m
//  DFBaseDemocOC
//
//  Created by user on 15/11/18.
//  Copyright © 2018年 DF. All rights reserved.
//

#import "AppDelegate.h"
#import "DFShareUtils.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [DFShareUtils confitSharePlatforms];
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    return [DFShareUtils openURL:url options:options];
}


@end
