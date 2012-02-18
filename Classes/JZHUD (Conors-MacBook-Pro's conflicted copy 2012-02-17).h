//
//  JZHUD.h
//  QRZar
//
//  Created by Conor Brady on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ZXingWidgetController.h"
#import "JZQRInfo.h"



@interface JZHUD : UIViewController <ZXingDelegate, CLLocationManagerDelegate>{
    ZXingWidgetController *widController;
    IBOutlet UIImageView* badge;
    IBOutlet UIImageView* bg;
    IBOutlet UILabel* blueTeamScore;
    IBOutlet UILabel* redTeamScore;
    JZQRInfo* info;
    int time;
    IBOutlet UILabel* timer;
    
}

@property (nonatomic, retain) ZXingWidgetController*        widController;
@property (nonatomic, retain) IBOutlet  UIImageView*        badge;
@property (nonatomic, retain) IBOutlet  UIImageView*        bg;
@property (nonatomic, retain) IBOutlet  UIImageView*        movingBG;
@property (nonatomic, retain)           JZQRInfo*           info;
@property (nonatomic)                   int                 time;
@property (nonatomic, retain) IBOutlet  UILabel*            timer;
@property (nonatomic, retain) IBOutlet  UILabel*            blueTeamScore;
@property (nonatomic, retain) IBOutlet  UILabel*            redTeamScore;
@property (nonatomic, retain) IBOutlet  UIView*             powerUpPanel;
@property (nonatomic, retain) IBOutlet  UIImageView*        bonus;
@property (nonatomic, retain) IBOutlet  UIImageView*        trim;
@property (nonatomic, retain) IBOutlet  UIImageView*        cogs;

@property (nonatomic, retain)           CLLocationManager*  locationManager;
@property (nonatomic, retain)           CLLocation*         location;


-(void)passJoinScan:(JZQRInfo*)i;
-(void)countdown;
-(void)endGame;
-(IBAction)scanButtonWasPressed;
-(IBAction)scanButtonWasReleased;
-(IBAction)powerUpPanel;
-(IBAction)dismissPowerUpPanel;
-(IBAction)serverPing;

@end
