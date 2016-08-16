//
//  ParrotComposer.h
//  ParrotIM
//
//  Created by youknowone on 11. 9. 5..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#import "CIMComposer.h"
#include <poll.h>

@interface ParrotComposer : NSObject<CIMComposer> {
    NSMutableString *originalString;
    NSMutableString *commitString;
    NSMutableString *composedString;
    NSString *endian;
    
    pid_t pid;
    int pipes[2];
    struct pollfd ufd;
}
@property(nonatomic, retain) NSString *endian;

@end
