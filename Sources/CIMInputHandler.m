#import "BowdlatorInputManager.h"
#import "CIMInputHandler.h"
#import "BowdlatorComposer.h"

#define DEBUG_INPUTHANDLER TRUE

@implementation CIMInputHandler
@synthesize manager;

- (id)initWithManager:(BowdlatorInputManager *)aManager {
    self = [super init];
    ICLog(DEBUG_INPUTHANDLER, @"** CIMInputHandler inited: %@ / with manage: %@", self, aManager);
    if (self) {
        self->manager = aManager;
    }
    return self;
}

- (void)setManager:(BowdlatorInputManager *)aManager {
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