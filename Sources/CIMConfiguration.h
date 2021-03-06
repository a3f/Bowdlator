#import <Foundation/Foundation.h>

ICEXTERN NSString *kCIMLastHangulInputMode;

#define CIMConfigurationStringItemCount 1

#define CIMConfigurationIntegerItemCount 0

#define CIMConfigurationBoolItemCount 0

#define defCIMConfigurationItem(NAME, TYPE) struct NAME { NSString *name; TYPE *pConfiguration; TYPE defaultValue; }

defCIMConfigurationItem(CIMConfigurationStringItem, NSString *);
defCIMConfigurationItem(CIMConfigurationIntegerItem, NSInteger);
defCIMConfigurationItem(CIMConfigurationBoolItem, BOOL);

#undef defCIMConfigurationItem

#define CIMConfigurationSetObjectForField(CONF, OBJ, FIELD)   { [CONF->FIELD autorelease]; CONF->FIELD = [OBJ retain]; }

@interface CIMConfiguration : NSObject {
@private
    NSMutableDictionary *pFieldKeys;
    struct CIMConfigurationStringItem stringItems[CIMConfigurationStringItemCount];
    struct CIMConfigurationIntegerItem integerItems[CIMConfigurationIntegerItemCount];
    struct CIMConfigurationBoolItem boolItems[CIMConfigurationBoolItemCount];
    NSMutableDictionary *originConfigurations;
    NSUserDefaults *userDefaults;
@public
    NSString *lastHangulInputMode;
}
@property(nonatomic, retain) NSUserDefaults *userDefaults;

- (id)initWithUserDefaults:(NSUserDefaults *)userDefaults;

- (void)saveAllConfigurations;
- (void)loadAllConfigurations;
- (void)saveConfigurationForStringField:(NSString **)pField;

@end
