#include "CIMComposer.h"

@implementation CIMBaseComposer

- (NSString *)composedString {
    return @"";
}

- (NSString *)originalString {
    return @"";
}

- (NSString *)commitString {
    return @"";
}

- (NSString *)dequeueCommitString {
    return @"";
}

- (void)cancelComposition { }

- (void)clearContext { }

#pragma -

- (BOOL)inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender {
    return NO;
}

@end