//
//  JZOneSecondBlocker.m
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZOneSecondBlocker.h"

@implementation JZOneSecondBlocker

@synthesize blocker;

- (id)init {
    self = [super init];
    if (self) {
        blocker = false;
    }
    return self;
}

-(BOOL)check{
    if (blocker) {
        return false;
    }else{
        [self block];
        return true;
    }
}

-(void)block{
    blocker = true;
    [self performSelector:@selector(unblock) withObject:nil afterDelay:1];
}

-(void)unblock{
    blocker = false;
}

@end
