//
//  ViewController.m
//  Sunrise
//
//  Created by Stuart Moore on 8/26/14.
//  Copyright (c) 2014 Stuart J. Moore. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *jsPath = [NSBundle.mainBundle pathForResource:@"hide_toolbar" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController *userContentController = [WKUserContentController new];
    [userContentController addUserScript:script];
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.userContentController = userContentController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
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
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    [self.webView loadRequest:request];
}

#pragma mark - Actions

- (void)toggleMenu {
    NSString *jsPath = [NSBundle.mainBundle pathForResource:@"toggle_menu" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView evaluateJavaScript:jsString completionHandler:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)scrollDateVisible:(ViewDirection)direction {
    NSString *jsPath;
    
    switch (direction) {
        case ViewDirectionDecrease:
            jsPath = [NSBundle.mainBundle pathForResource:@"scroll_decrease" ofType:@"js"];
            break;
        case ViewDirectionToday:
            jsPath = [NSBundle.mainBundle pathForResource:@"scroll_to_today" ofType:@"js"];
            break;
        case ViewDirectionIncrease:
            jsPath = [NSBundle.mainBundle pathForResource:@"scroll_increase" ofType:@"js"];
            break;
    }
    
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView evaluateJavaScript:jsString completionHandler:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)showInvitationsPopover {
    NSString *jsPath = [NSBundle.mainBundle pathForResource:@"invite_popover" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView evaluateJavaScript:jsString completionHandler:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)showViewType:(ViewType)type {
    NSString *jsPath;
    
    switch (type) {
        case ViewTypeMonth:
            jsPath = [NSBundle.mainBundle pathForResource:@"display_month" ofType:@"js"];
            break;
        case ViewTypeWeek:
            jsPath = [NSBundle.mainBundle pathForResource:@"display_week" ofType:@"js"];
            break;
    }
    
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView evaluateJavaScript:jsString completionHandler:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

#pragma mark - WKUIDelegate

- (WKWebView*)webView:(WKWebView*)webView createWebViewWithConfiguration:(WKWebViewConfiguration*)config forNavigationAction:(WKNavigationAction*)navigationAction windowFeatures:(WKWindowFeatures*)windowFeatures {
    NSRect halfFrame = self.view.bounds;
    halfFrame.size.width /= 2;
    halfFrame.size.height /= 2;
    
    NSWindow *sheet = [[NSWindow alloc] init];
    [sheet setFrame:halfFrame display:YES];
    
    WKWebView *modalWebView = [[WKWebView alloc] initWithFrame:[sheet.contentView bounds] configuration:config];
    modalWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [sheet.contentView addSubview:modalWebView];
    
    [sheet.contentView addConstraints:@[[NSLayoutConstraint constraintWithItem:sheet.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:modalWebView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:1
                                                                      constant:0],
                                        [NSLayoutConstraint constraintWithItem:sheet.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:modalWebView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:1
                                                                      constant:0]]];
    
    [modalWebView loadRequest:navigationAction.request];
    
    [self.view.window beginSheet:sheet completionHandler:^(NSModalResponse code) {
    }];
    
    return modalWebView;
}

@end
