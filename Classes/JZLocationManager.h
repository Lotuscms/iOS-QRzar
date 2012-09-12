//
//  JZLocationManager.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface JZLocationManager : NSObject <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) CLLocation* currentLocation;
@property (nonatomic, retain) CLLocationManager* locationManager;

-(double)getLong;
-(double)getLat;
-(double)getRadius;

@end
