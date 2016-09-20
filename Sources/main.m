#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdlib.h>
#include <pthread.h>

#include "logerrno.h"
#include "acceptor.h"


#define SOCK_PATH "/usr/local/var/run/bowdlator.sock"
int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    ICLog(TRUE, @__DATE__ " " __TIME__);
    int fd;
    

    if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
        logerrno("socket");
        exit(-1);
    }
    
    unlink(SOCK_PATH);
    struct sockaddr_un addr = {
        .sun_family = AF_UNIX,
        .sun_path = SOCK_PATH,
    };
    
    if (bind(fd, (struct sockaddr*)&addr, sizeof addr ) == -1) {
        logerrno("bind");
        exit(-1);
    }
    
    if (listen(fd, 5) == -1) {
        logerrno("listen");
        exit(-1);
    }
    
    pthread_t acceptor_thrd;
    pthread_create(&acceptor_thrd, NULL, acceptor, &fd);
    pthread_detach(acceptor_thrd);

    signal(SIGPIPE, SIG_IGN);
 
    ICLog(TRUE, @"******* CharmIM initialized! *******");
    NSString *mainNibName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"NSMainNibFile"];
    if ([NSBundle loadNibNamed:mainNibName owner:[NSApplication sharedApplication]] == NO) {
        NSLog(@"!! CharmIM fails to load Main Nib File !!");
    }
    ICLog(TRUE, @"****   Main bundle %@ loaded   ****", mainNibName);
   
    [[NSApplication sharedApplication] run];
    
    ICLog(TRUE, @"******* CharmIM finalized! *******");
    [pool release];
    return 0;
}

