//
//  ParrotAppDelegate.m
//  CharmIM
//
//  Created by youknowone on 11. 9. 1..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#import "ParrotInputManager.h"
#import "ParrotAppDelegate.h"

@implementation ParrotAppDelegate
@synthesize inputManager;

@end

@implementation ParrotAppDelegate (SharedObject)

+ (ParrotAppDelegate *)sharedAppDelegate {
    return [[NSApplication sharedApplication] delegate];
}

@end

// CIMInputManager (SharedObject)의 IM 구현
@implementation ParrotInputManager (SharedObject)

+ (ParrotInputManager *)sharedManager {
    return [[ParrotAppDelegate sharedAppDelegate] inputManager];
}

@end