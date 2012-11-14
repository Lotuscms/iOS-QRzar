//
//  JZGlobalResources.m
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZGlobalResources.h"

static JZGlobalResources* sharedResources = nil;

@implementation JZGlobalResources

@synthesize locationManager = _locationManager;
@synthesize topHatConnect = _topHatConnect;
@synthesize managedObjectContext = _managedObjectContext;


+(JZGlobalResources*)sharedInstance{
	
	if (sharedResources == nil) {
		
		sharedResources = [[JZGlobalResources alloc] init];
		
		if (sharedResources) {
			if((sharedResources.topHatConnect =[[JZTopHatConnect alloc] init])==NULL || (sharedResources.locationManager = [[JZLocationManager alloc] init])==NULL ){
				sharedResources = NULL;
			}
		}
	}
	return sharedResources;
}




@end
