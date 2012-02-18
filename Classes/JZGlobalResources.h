//
//  JZGlobalResources.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZOneSecondBlocker.h"
#import "JZLocationManager.h"
#import "JZTopHatConnect.h"

@interface JZGlobalResources : NSObject

@property  (nonatomic, retain) JZOneSecondBlocker* blocker;
@property  (nonatomic, retain) JZLocationManager* locationManager;
@property  (nonatomic, retain) JZTopHatConnect* topHatConnect;


@end
