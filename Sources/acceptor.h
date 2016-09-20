#ifndef acceptor_h
#define acceptor_h


#include <sys/select.h>
extern fd_set filters;
extern int maxfd;

void *acceptor(void* fd);

#endif /* acceptor_h */
