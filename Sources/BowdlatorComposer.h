#import "CIMComposer.h"
#include <poll.h>

@interface BowdlatorComposer : NSObject<CIMComposer> {
    NSMutableString *originalString;
    NSMutableString *commitString;
    NSMutableString *composedString;
    
}

@end
