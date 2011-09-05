//
//  ParrotAppDelegate.h
//  CharmIM
//
//  Created by youknowone on 11. 9. 1..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ParrotInputManager;

@interface ParrotAppDelegate : NSObject<NSApplicationDelegate> {
@private
    IBOutlet ParrotInputManager *inputManager;
    IBOutlet NSMenu *menu;
}

@property(nonatomic, readonly) ParrotInputManager *inputManager;

@end

@interface ParrotAppDelegate (SharedObject)

+ (ParrotAppDelegate *)sharedAppDelegate;

@end
