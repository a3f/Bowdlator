//
//  ParrotComposer.h
//  ParrotIM
//
//  Created by youknowone on 11. 9. 5..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#import "CIMComposer.h"

@interface ParrotComposer : NSObject<CIMComposer> {
    NSMutableString *originalString;
    NSMutableString *commitString;
    NSString *endian;
}
@property(nonatomic, retain) NSString *endian;

@end
