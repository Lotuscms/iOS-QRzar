//
//  JZLocationManager.m
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZLocationManager.h"

@interface JZLocationManager (PrivateMethods)

-(void) createLocationManager;

@end

@implementation JZLocationManager

@synthesize currentLocation = _currentLocation;
@synthesize locationManager = _locationManager;

- (id)init {
    self = [super init];
    if (self) {
		[self performSelectorOnMainThread:@selector(createLocationManager) withObject:NULL waitUntilDone:YES];
        
    }
    return self;
}

-(void)createLocationManager{
	[self setLocationManager:[[CLLocationManager alloc] init]];
	[[self locationManager] setDelegate:self];
	[[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
	[[self locationManager] startUpdatingLocation];
}
		 
		 
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	
	[self setCurrentLocation:newLocation];
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	
	switch([error code])
	{
		case kCLErrorNetwork:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Location" message:@"Please check your network connection or that you are not in airplane mode." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
			[alert show];
		}
			break;
		case kCLErrorDenied:{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Location" message:@"This app requires use of your current location, it will now exit." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
			[alert show];
		}
			break;
		default:{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Location" message:@"Unknown network error, game will now exit." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
			[alert show];
		}
			break;
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex==0) {
		exit(0);
	}
}

-(double)getLong{
    return self.currentLocation.coordinate.longitude;
}

-(double)getLat{
    return self.currentLocation.coordinate.latitude;
}

-(double)getRadius{
    return self.currentLocation.horizontalAccuracy;
}

@end
