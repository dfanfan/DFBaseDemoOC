//
//  DFRootWebViewController.h
//  iCamdora
//
//  Created by user on 1/8/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import "DFRootViewController.h"
#import <WebKit/WebKit.h>


@interface DFRootWebViewController : DFRootViewController
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, assign) BOOL isShare;   //是否分享
@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, copy) NSString *thumbImageUrl;
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) UIColor *bgColor;
@end
