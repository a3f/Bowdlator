//
//  logerrno.h
//  ParrotIM
//
//  Created by Ahmad Fatoum on 19/09/16.
//  Copyright © 2016 a3f.at. All rights reserved.
//

#ifndef logerrno_h
#define logerrno_h

#include <stdio.h>
#include <errno.h>

#define logerrno(s, ...) NSLog(@"" s ": %s", ## __VA_ARGS__, strerror(errno))



#endif /* logerrno_h */
