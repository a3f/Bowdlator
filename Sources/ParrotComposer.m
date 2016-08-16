//
//  ParrotComposer.m
//  ParrotIM
//
//  Created by youknowone on 11. 9. 5..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#include <poll.h>
#import "ParrotComposer.h"

@implementation ParrotComposer
@synthesize endian;

- (id)init {
    NSLog(@"********************-INIT");
    self = [super init];
    if (self != nil) {
        originalString = [[NSMutableString alloc] init];
        commitString = [[NSMutableString alloc] init];
        composedString = [[NSMutableString alloc] init];
    }
    pipes[0] = -1;
    ufd.events = 0;
    return self;
}

- (void) dealloc {
    NSLog(@"********************-DECALLOC");
    [commitString release];
    [originalString release];
    [composedString release];
    
    if (pipes[0] >= 0) {
        close(pipes[0]);
        close(pipes[1]);
        pipes[0] = -1;
    }
    
    [super dealloc];
}

- (NSString *)composedString {
    NSLog(@"composedString called: %@", composedString);
    return composedString;
}

- (NSString *)originalString {
    NSLog(@"originalString called: %@", originalString);
    return originalString;
}

- (NSString *)commitString {
    NSLog(@"commitString called: %@", commitString);
    return commitString;
}

- (NSString *)dequeueCommitString {
    NSString *string = [NSString stringWithString:commitString];
    NSLog(@"dequeueCommitString called: %@", string);
    [commitString setString:@""];
    return string;
}

- (void)commitComposition:(id)sender {
    NSLog(@"commitComposition called.");
    
    if (pipes[0] >= 0) {
        close(pipes[0]);
        close(pipes[1]);
        pipes[0] = -1;
    }
    [sender insertText:commitString replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    
    [commitString setString:composedString];
    [originalString setString:@""];
}

- (void)cancelComposition {
    NSLog(@"cancelComposition called.");
    
    if (pipes[0] >= 0) {
        close(pipes[0]);
        close(pipes[1]);
        pipes[0] = -1;
    }
    
    [commitString setString:composedString];
    [composedString setString:@""];
    [originalString setString:@""];
}

- (void)clearContext {
    NSLog(@"clearContext called.");
    [originalString setString:@""];
    [commitString setString:@""];
    [composedString setString:@""];
}

#pragma -

static pid_t pcreate(int fds[2], const char *cmd, char **args);

- (BOOL)inputText:(NSString *)string_ key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender {
    if (pipes[0] < 0) {
        NSLog(@"Forking");
        pid = pcreate(pipes, "/Users/a3f/symlinks/inputfilter", (char*[]){NULL});
        ufd.fd = pipes[1];
    }
    self.endian = nil;
    //FIXME modifies!
    if (keyCode == 0x33) {
        NSLog(@"Backspacke");
        if ([originalString length] == 0) return NO;
        [originalString deleteCharactersInRange:NSMakeRange([originalString length]-1, 1)];
        string_ = @"\b";
    }
    NSString *string = [string_ stringByAppendingString:@"\n"];
    ssize_t nbytes;
    nbytes = write(pipes[1], string.UTF8String, string.length);
    NSLog(@"Wrote %zd bytes", nbytes);
    char buf[160];//what size?
    nbytes = read(pipes[0], buf, sizeof buf);
    NSLog(@"Read %zd bytes", nbytes);
    buf[nbytes] = '\0';
    if (nbytes < 2) {
        NSLog(@"ParrotComposer -inputText: reading failed %d", errno);
        [self cancelComposition];
        return NO;//cancel
    }
    NSString *str = [NSString stringWithUTF8String:buf];
    NSArray *suggestions = [str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    (void) suggestions; // display suggestions somehow
    [composedString setString:suggestions[0]];
    if (buf[nbytes-2] == '\4') {
        [self cancelComposition];
        NSLog(@"ParrotComposer -inputText: composition finished: %@", suggestions[0]);
        return NO;
    }
    
    NSLog(@"ParrotComposer -inputText: composed %@ so far", suggestions[0]);
 
    [originalString appendString:string];
    return YES;
}

@end
static pid_t pcreate(int fds[2], const char *cmd, char **args) {
    pid_t pid;
    int pipes[4];
    
    
    if (pipe(&pipes[0]) == -1) return -1; /* Parent read/child write pipe */
    if (pipe(&pipes[2]) == -1) return -1; /* Child read/parent write pipe */
    
    pid = fork();
    switch(pid) {
        case -1:
            return -1;
        case 0:
            close(pipes[0]);
            dup2(pipes[1], 1);
            dup2(pipes[2], 0);
            close(pipes[3]);
            
            execv(cmd, args);
        default:
            /* Parent process */
            fds[0] = pipes[0];
            fds[1] = pipes[3];
            
            close(pipes[1]);
            close(pipes[2]);
            
            return pid;
    }
    return -1;
}


