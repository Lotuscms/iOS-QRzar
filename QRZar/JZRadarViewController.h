//
//  JZRadarViewController.h
//  QRZar
//
//  Created by Conor Brady on 08/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JZRadarView.h"
#import "JZLocationManager.h"

@interface JZRadarViewController : UIViewController<LocationManagerListenerDelegate>{

	NSTimer* _loopTimer;
}


@property (nonatomic, retain) IBOutlet JZRadarView* radarView;
@property (nonatomic, retain) NSTimer* loopTimer;
@property (nonatomic, retain) IBOutlet UIButton* zoomIn;
@property (nonatomic, retain) IBOutlet UIButton* zoomOut;
@property (nonatomic, retain) IBOutlet UILabel* feedbackLabel;

-(IBAction)zoom:(id)sender;

@end
