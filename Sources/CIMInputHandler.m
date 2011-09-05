//
//  CIMInputHandler.m
//  CharmIM
//
//  Created by youknowone on 11. 9. 1..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#import "ParrotInputManager.h"
#import "CIMInputHandler.h"
#import "ParrotComposer.h"

#define DEBUG_INPUTHANDLER TRUE

@implementation CIMInputHandler
@synthesize manager;

- (id)initWithManager:(ParrotInputManager *)aManager {
    self = [super init];
    ICLog(DEBUG_INPUTHANDLER, @"** CIMInputHandler inited: %@ / with manage: %@", self, aManager);
    if (self) {
        self->manager = aManager;
    }
    return self;
}

- (void)setManager:(ParrotInputManager *)aManager {
    self->manager = aManager;
}

#pragma - IMKServerInputTextData

- (BOOL)inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender {   
    if (flags & NSCommandKeyMask) {
        ICLog(TRUE, @"-- CIMInputHandler -inputText: Command key input / returned NO");
        return NO;
    }
    return [self->manager.currentComposer inputText:string key:keyCode modifiers:flags client:sender];
}

@end