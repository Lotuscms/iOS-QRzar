//
//  JZGlobalResources.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JZLocationManager.h"
#import "JZTopHatConnect.h"

@interface JZGlobalResources : NSObject{
	JZLocationManager* _locationManager;
	JZTopHatConnect* _topHatConnect;

}

@property (nonatomic, retain) JZLocationManager* locationManager;
@property (nonatomic, retain) JZTopHatConnect* topHatConnect;
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;


+(JZGlobalResources*)sharedInstance;

@end
