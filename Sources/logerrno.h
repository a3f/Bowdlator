#ifndef logerrno_h
#define logerrno_h

#include <stdio.h>
#include <errno.h>

#define logerrno(s, ...) NSLog(@"" s ": %s", ## __VA_ARGS__, strerror(errno))



#endif /* logerrno_h */
