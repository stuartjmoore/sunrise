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
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"document.getElementsByClassName('app-navbar')[0].style.display = \"none\";\
                                                                  document.getElementsByClassName('app-wrapper')[0].style.top = 0;"
                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                               forMainFrameOnly:YES];
    
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
    NSString *jsString = @"\
        var menu_item = document.getElementsByClassName('navbar__item--menu')[0]; \
        menu_item.firstChild.click(); \
    ";
    
    [self.webView evaluateJavaScript:jsString completionHandler:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)scrollDateVisible:(ViewDirection)direction {
    NSString *jsString;
    
    switch (direction) {
        case ViewDirectionDecrease:
            jsString = @"\
                var menu_item = document.getElementsByClassName('navbar__item--controls')[0]; \
                menu_item.getElementsByClassName('js-navbar-controls-prev')[0].click(); \
            ";
            break;
        case ViewDirectionToday:
            jsString = @"\
                var menu_item = document.getElementsByClassName('navbar__item--today')[0]; \
                menu_item.firstChild.click(); \
            ";
            break;
        case ViewDirectionIncrease:
            jsString = @"\
                var menu_item = document.getElementsByClassName('navbar__item--controls')[0]; \
                menu_item.getElementsByClassName('js-navbar-controls-next')[0].click(); \
            ";
            break;
    }
    
    [self.webView evaluateJavaScript:jsString completionHandler:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)showInvitationsPopover {
    NSString *jsString = @"\
        var menu_item = document.getElementsByClassName('invitations-logo')[0]; \
        menu_item.click(); \
    ";
    
    [self.webView evaluateJavaScript:jsString completionHandler:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
}

- (void)showViewType:(ViewType)type {
    NSString *jsString;
    
    switch (type) {
        case ViewTypeMonth:
            jsString = @"\
                var menu_item = document.getElementsByClassName('navbar__item--location')[0]; \
                menu_item.getElementsByClassName('navbar__item--location__month')[0].click(); \
            ";
            break;
        case ViewTypeWeek:
            jsString = @"\
                var menu_item = document.getElementsByClassName('navbar__item--location')[0]; \
                menu_item.getElementsByClassName('navbar__item--location__week')[0].click(); \
            ";
            break;
    }
    
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
