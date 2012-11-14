//
//  JZLocationManager.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerListenerDelegate <NSObject>

-(void)headingUpdate:(CLHeading*)heading;

@end


@interface JZLocationManager : NSObject <CLLocationManagerDelegate, UIAlertViewDelegate>{
	CLLocation* _currentLocation;
	CLLocationManager* _locationManager;
	NSObject<LocationManagerListenerDelegate>* _delegate;
	
}

@property (nonatomic, strong) CLLocation* currentLocation;
@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) NSObject<LocationManagerListenerDelegate>* delegate;

-(double)getLong;
-(double)getLat;
-(double)getRadius;

@end
