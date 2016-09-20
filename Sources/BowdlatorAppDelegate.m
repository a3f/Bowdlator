#import "BowdlatorInputManager.h"
#import "BowdlatorAppDelegate.h"

@implementation BowdlatorAppDelegate
@synthesize inputManager;

@end

@implementation BowdlatorAppDelegate (SharedObject)

+ (BowdlatorAppDelegate *)sharedAppDelegate {
    return [[NSApplication sharedApplication] delegate];
}

@end

@implementation BowdlatorInputManager (SharedObject)

+ (BowdlatorInputManager *)sharedManager {
    return [[BowdlatorAppDelegate sharedAppDelegate] inputManager];
}

@end