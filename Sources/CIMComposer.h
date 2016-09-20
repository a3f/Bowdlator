#import "CIMCommon.h"

@protocol CIMComposer<IMKServerInputTextData>
@property(nonatomic, readonly) NSString *composedString;
@property(nonatomic, readonly) NSString *originalString;
@property(nonatomic, readonly) NSString *commitString;
- (NSString *)dequeueCommitString;
- (void)cancelComposition;
- (void)clearContext;
@optional

@end


@interface CIMBaseComposer : NSObject<CIMComposer> 

@end