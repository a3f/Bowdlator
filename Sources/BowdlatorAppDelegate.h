#import <Cocoa/Cocoa.h>

@class BowdlatorInputManager;

@interface BowdlatorAppDelegate : NSObject<NSApplicationDelegate> {
@private
    IBOutlet BowdlatorInputManager *inputManager;
    IBOutlet NSMenu *menu;
}

@property(nonatomic, readonly) BowdlatorInputManager *inputManager;

@end

@interface BowdlatorAppDelegate (SharedObject)

+ (BowdlatorAppDelegate *)sharedAppDelegate;

@end
