//
//  acceptor.h
//  ParrotIM
//
//  Created by Ahmad Fatoum on 19/09/16.
//  Copyright © 2016 a3f.at. All rights reserved.
//

#ifndef acceptor_h
#define acceptor_h


#include <sys/select.h>
extern fd_set filters;
extern int maxfd;

void *acceptor(void* fd);

#endif /* acceptor_h */
