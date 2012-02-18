//
//  JZGlobalResources.m
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZGlobalResources.h"


@implementation JZGlobalResources

@synthesize topHatConnect, blocker, locationManager;

- (id)init {
    self = [super init];
    if (self) {
        topHatConnect =     [[JZTopHatConnect alloc] init];
        blocker =           [[JZOneSecondBlocker alloc] init];
        locationManager =   [[JZLocationManager alloc] init];
    }
    return self;
}

@end
