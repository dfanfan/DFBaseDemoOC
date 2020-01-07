//
//  DFRootWebViewController.m
//  iCamdora
//
//  Created by user on 1/8/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import "DFRootWebViewController.h"

@interface DFRootWebViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation DFRootWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.webTitle;
    [self setBottomLine:NO];
    [self setupUI];
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        CGRect frame = self.view.bounds;
        frame.size.height = 1;
        _progressView = [[UIProgressView alloc] initWithFrame:frame];
        _progressView.tintColor = [UIColor orangeColor];
        _progressView.trackTintColor = [UIColor whiteColor];
        [self.webView addSubview:_progressView];
    }
    return _progressView;
}

- (void)setupUI {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = YES;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    if (self.bgColor) {
        [webView setBackgroundColor:self.bgColor];
        webView.opaque = NO;
    }
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.webUrl) {
        NSURL *url = [NSURL URLWithString:self.webUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
        [webView loadRequest:request];
    }
    
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self hideNavView]) {
            make.top.equalTo(@0);
        }else {
            make.top.equalTo(self.navView.mas_bottom).offset(0);
        }
        make.leading.trailing.bottom.equalTo(@0);
    }];
    
    
    
//    if (self.isShare && [CDAShareUtils hasPlatforms]) {
//        UIButton *shareBtn = [[UIButton alloc] init];
//        [shareBtn setImage:[UIImage imageNamed:@"common_share"] forState:UIControlStateNormal];
//        [shareBtn addTarget:self action:@selector(clickShare) forControlEvents:UIControlEventTouchUpInside];
//        [self setRightButtons:@[shareBtn]];
//    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }
}

//- (void)clickShare {
//    NSLog(@"===== clickShare");
//    CDAShareObject *shareObject = [[CDAShareObject alloc] init];
//    shareObject.webUrl = self.webUrl;
//    shareObject.shareTitle = self.webTitle;
//    shareObject.thumbUrl = self.thumbImageUrl;
//    [CDAShareUtils showSharePlatforms:self object:shareObject complete:nil];
//}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
