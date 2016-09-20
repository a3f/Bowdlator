#import "CIMCommon.h"

@class BowdlatorInputManager;

@interface CIMInputHandler : NSObject<IMKServerInputTextData> {
@private
    BowdlatorInputManager *manager;
}

@property(nonatomic, readonly) BowdlatorInputManager *manager;
- (void)setManager:(BowdlatorInputManager *)aManager;

- (id)initWithManager:(BowdlatorInputManager *)manager;

@end
