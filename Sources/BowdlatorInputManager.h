#import <Foundation/Foundation.h>
#import <InputMethodKit/InputMethodKit.h>

#import "CIMComposer.h"

@class CIMConfiguration;
@class CIMInputHandler;

#define InputManager [BowdlatorInputManager sharedManager]

@interface BowdlatorInputManager : NSObject<IMKServerInputTextData> {
@private
    IMKServer *server;
    CIMConfiguration *configuration;
    CIMInputHandler *handler;
    NSObject<CIMComposer> *currentComposer;
}

@property(nonatomic, readonly) IMKServer *server;
@property(nonatomic, readonly) CIMConfiguration *configuration;
@property(nonatomic, readonly) CIMInputHandler *handler;
@property(nonatomic, readonly) NSObject<CIMComposer> *currentComposer;

@end

@interface BowdlatorInputManager (SharedObject)

+ (BowdlatorInputManager *)sharedManager;

@end
