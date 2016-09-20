#include <poll.h>
#include <sys/socket.h>
#include "acceptor.h"
#include "logerrno.h"
#import "BowdlatorComposer.h"

@implementation BowdlatorComposer

- (id)init {
    NSLog(@"********************-INIT");
    self = [super init];
    if (self != nil) {
        originalString = [[NSMutableString alloc] init];
        commitString = [[NSMutableString alloc] init];
        composedString = [[NSMutableString alloc] init];
    }
    return self;
}

- (void) dealloc {
    NSLog(@"********************-DECALLOC");
    [commitString release];
    [originalString release];
    [composedString release];
    
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
    
    [sender insertText:commitString replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    
    [commitString setString:composedString];
    [originalString setString:@""];
}

- (void)cancelComposition {
    NSLog(@"cancelComposition called.");
    
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

- (BOOL)inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender {
    //FIXME modifies!
    if (keyCode == 0x33) {
        NSLog(@"Backspace");
        if ([originalString length] == 0) return NO;
        [originalString deleteCharactersInRange:NSMakeRange([originalString length]-1, 1)];
        string = @"\b";
    }

    ssize_t nbytes = -1;
    for (int i = 0; i <= maxfd; i++) {
        if (FD_ISSET(i, &filters)) {
            NSUInteger bytes = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            nbytes = write(i, string.UTF8String, bytes + 1);
            if (nbytes == -1) {
                logerrno("write");
                FD_CLR(i, &filters);
            }
        }
    }
    if (nbytes == -1) {
        [self cancelComposition];
        return NO; //cancel
    }

    NSLog(@"Wrote %zd bytes: [%@]", nbytes, string);
    fd_set responsive_filters = filters;
    //TODO: loop
    int n = select(maxfd+1, &responsive_filters, NULL, NULL, &(struct timeval) {.tv_usec=100000});
    if (n < 0) {
        logerrno("select");
    }
    
    NSMutableArray *suggestions = [NSMutableArray array];
    for (int i = 0; i <= maxfd; i++) {
        if (!FD_ISSET(i, &responsive_filters))
            continue;
        
        char buf[161];//what size?
        nbytes = read(i, buf, sizeof buf - 1);
        if (nbytes == 0) {
            FD_CLR(i, &filters);
            shutdown(i, SHUT_RDWR);
            close(i);
        }
        NSLog(@"Read %zd bytes: [%.*s] from %d", nbytes, (int)nbytes, buf, i);
        if (buf[nbytes-1] != '\0') {
            buf[nbytes++] = '\0';
        }
        char *pbuf = buf;
        while (nbytes) {
            if (*pbuf == '\4') {
                [composedString setString:suggestions[0]];
                [self cancelComposition];
                NSLog(@"BowdlatorComposer -inputText: Ocomposition finished: %@", suggestions[0]);
                return NO;
            }
            NSString *str = [NSString stringWithUTF8String:pbuf];
            NSUInteger len = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"String (nbytes=%zd): %s-%@", nbytes, pbuf, str);
            [suggestions addObject: str];
            nbytes -= len + 1;
            pbuf += len + 1;
        }
    }
    if (suggestions.count == 0) {
            NSLog(@"BowdlatorComposer -inputText: no suggestions received");
            [self cancelComposition];
            return NO;//cancel
    }
    (void) suggestions; // display suggestions somehow
    [composedString setString:suggestions[0]];
    
    NSLog(@"BowdlatorComposer -inputText: composed %@ so far", suggestions[0]);
 
    [originalString appendString:string];
    return YES;
}

@end
