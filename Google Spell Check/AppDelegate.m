//
//  AppDelegate.m
//  Google Spell Check
//
//  Created by Chris Ziraldo on 2013-06-03.
//  Copyright (c) 2013 Chris Ziraldo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:[NSImage imageNamed:@"GoodIcon.png"]];
//    [statusItem setTarget:self];
//    [statusItem setAction:@selector(Click:)];
    
    [self performSelectorOnMainThread:@selector(WatchPasteboard:) withObject:nil waitUntilDone:NO];
}

- (void)StripPasteboard:(id)sender
{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSString * tempString =  [pasteboard stringForType:NSPasteboardTypeString ];
    [pasteboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString ] owner:nil];
    [pasteboard setString: tempString forType:NSPasteboardTypeString ];
}

- (void)WatchPasteboard:(id)sender
{
    NSString * CurrentPasteboard = @"";
    NSString * PreviousPasteboard = @"";
    NSArray * CurrentArray;
    
    while (true)
    {
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        CurrentPasteboard =  [pasteboard stringForType:NSPasteboardTypeString ];
        if(![CurrentPasteboard isEqualToString: PreviousPasteboard])
        {
            CurrentArray = [CurrentPasteboard componentsSeparatedByString:@" "];
            
            for (int i = 0; i < [CurrentArray count]; i++)
            {
                NSLog(@"%@",[CurrentArray objectAtIndex:i]);
            }
            
        
        }
        
        PreviousPasteboard = CurrentPasteboard;
        
        [NSThread sleepForTimeInterval:0.25];
    }
}

@end
