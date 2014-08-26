//
//  ViewController.m
//  Sunrise
//
//  Created by Stuart Moore on 8/26/14.
//  Copyright (c) 2014 Stuart J. Moore. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet WKWebView *webView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"document.getElementsByClassName('app-navbar')[0].style.display = \"none\";\
                                                                  document.getElementsByClassName('app-wrapper')[0].style.top = 0;"
                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                               forMainFrameOnly:YES];
    
    WKUserContentController *userContentController = [WKUserContentController new];
    [userContentController addUserScript:script];
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.userContentController = userContentController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.webView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.webView
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.webView
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1
                                                              constant:0]]];
    
    NSURL *url = [NSURL URLWithString:@"https://calendar.sunrise.am/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

@end
