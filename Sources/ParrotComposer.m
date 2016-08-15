//
//  ParrotComposer.m
//  ParrotIM
//
//  Created by youknowone on 11. 9. 5..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#include <ctype.h>
#import "ParrotComposer.h"

@implementation ParrotComposer
@synthesize endian;

- (id)init {
    self = [super init];
    if (self != nil) {
        originalString = [[NSMutableString alloc] init];
        commitString = [[NSMutableString alloc] init];
    }
    return self;
}

- (void) dealloc {
    [commitString release];
    [originalString release];
    [super dealloc];
}

- (NSString *)composedString {
    return originalString;
}

- (NSString *)originalString {
    return originalString;
}

- (NSString *)commitString {
    return commitString;
}

- (NSString *)dequeueCommitString {
    NSString *string = [NSString stringWithString:commitString];
    [commitString setString:@""];
    return string;
}

- (void)cancelComposition { 
    [commitString appendString:originalString];
    [originalString setString:@""];
}

- (void)clearContext {
    [originalString setString:@""];
    [commitString setString:@""];
}

#pragma -

- (BOOL)inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender {
    unichar chr = [string characterAtIndex:0];
    self.endian = nil;
    if (keyCode == 0x33) {
        if ([originalString length] > 0) {
            [originalString deleteCharactersInRange:NSMakeRange([originalString length]-1, 1)];
            return YES;
        } else {
            return NO;
        }
    }
    BOOL handled = NO;
    if (isalnum(chr)) {
        handled = YES;
    }

    char *specials = "\"'`,-&%()";
    for (NSInteger i = 0; specials[i] > 0; i++) {
        if ((unichar)specials[i] == chr) {
            handled = YES;
            break;
        }
    }
    char *nonprefix = " ";
    for (NSInteger i = 0; nonprefix[i] > 0; i++) {
        if ((unichar)nonprefix[i] == chr) {
            handled = NO;//[originalString length] > 0;
            break;
        }
    }
    
    char *postfix = "?!.:;";
    for (NSInteger i = 0; postfix[i] > 0; i++) {
        if ((unichar)postfix[i] == chr) {
            self.endian = string;
        }
    }
    NSLog(@"ParrotComposer -inputText: return %d", handled);
    if (handled == YES) {
        [originalString appendString:string];
        return YES;
    }
    [self cancelComposition];
    return NO;
}

@end
