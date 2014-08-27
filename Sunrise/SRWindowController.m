//
//  SRWindowController.m
//  Sunrise
//
//  Created by Stuart Moore on 8/27/14.
//  Copyright (c) 2014 Stuart J. Moore. All rights reserved.
//

#import "SRWindowController.h"
#import "ViewController.h"

@interface SRWindowController ()

- (IBAction)menuButtonTap:(NSButton*)sender;
- (IBAction)scrollDateSegmentedTap:(NSSegmentedControl*)sender;
- (IBAction)invitationsButtonTap:(NSButton*)sender;
- (IBAction)switchViewSegmentedTap:(NSSegmentedControl*)sender;

@end

@implementation SRWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

#pragma mark - Toolbar Actions

- (IBAction)menuButtonTap:(NSButton*)sender {
    ViewController *viewController = (ViewController*)self.contentViewController;
    [viewController toggleMenu];
}

- (IBAction)scrollDateSegmentedTap:(NSSegmentedControl*)sender {
    ViewController *viewController = (ViewController*)self.contentViewController;
    
    switch (sender.selectedSegment) {
        case 0:
            [viewController scrollDateVisible:ViewDirectionDecrease];
            break;
            
        case 1:
            [viewController scrollDateVisible:ViewDirectionToday];
            break;
            
        case 2:
            [viewController scrollDateVisible:ViewDirectionIncrease];
            break;
    }
}

- (IBAction)invitationsButtonTap:(NSButton*)sender {
    ViewController *viewController = (ViewController*)self.contentViewController;
    [viewController showInvitationsPopover];
}

- (IBAction)switchViewSegmentedTap:(NSSegmentedControl*)sender {
    ViewController *viewController = (ViewController*)self.contentViewController;
    
    switch (sender.selectedSegment) {
        case 0:
            [viewController showViewType:ViewTypeWeek];
            break;
            
        case 1:
            [viewController showViewType:ViewTypeMonth];
            break;
    }
}

@end
