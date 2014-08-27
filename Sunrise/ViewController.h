//
//  ViewController.h
//  Sunrise
//
//  Created by Stuart Moore on 8/26/14.
//  Copyright (c) 2014 Stuart J. Moore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSUInteger, ViewType) {
    ViewTypeWeek,
    ViewTypeMonth
};

typedef NS_ENUM(NSUInteger, ViewDirection) {
    ViewDirectionDecrease,
    ViewDirectionToday,
    ViewDirectionIncrease
};

@interface ViewController : NSViewController <WKNavigationDelegate, WKUIDelegate>

- (void)toggleMenu;
- (void)scrollDateVisible:(ViewDirection)direction;
- (void)showInvitationsPopover;
- (void)showViewType:(ViewType)type;

@end

