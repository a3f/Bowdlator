//
//  main.m
//  CharmIM
//
//  Created by youknowone on 11. 8. 31..
//  Copyright 2011 youknowone.org. All rights reserved.
//

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
 
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
