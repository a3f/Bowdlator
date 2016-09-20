#import <Foundation/Foundation.h>

@protocol IMKServerInputTextData
@required

- (BOOL)inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender;

@end
