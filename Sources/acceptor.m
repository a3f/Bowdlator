//
//  acceptor.m
//  ParrotIM
//
//  Created by Ahmad Fatoum on 19/09/16.
//  Copyright © 2016 a3f.at. All rights reserved.
//

#include "acceptor.h"
#include <stddef.h>
#include <string.h>
#include <netinet/in.h>
#include <stdlib.h>

#include "logerrno.h"

int maxfd = -1;
fd_set filters;
static inline int max(int a, int b) { return a >= b ? a : b; }

void *acceptor(void* fd) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int sock = *(int*)fd;
    FD_ZERO(&filters);

    struct sockaddr_in clientname;
    socklen_t size = sizeof clientname;
    
    int new;
    while ((new = accept(sock, (struct sockaddr*)&clientname, &size)) >= 0) {
        NSLog(@"acceptor: accepted connect");
        FD_SET(new, &filters);
        maxfd = max(maxfd, new);
    }

    logerrno("accept");
    [pool release];
    exit(-1);
    return NULL;
}