//
//  JZHUD.h
//  QRZar
//
//  Created by Conor Brady on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "JZQRInfo.h"
#import "JZGlobalResources.h"



@interface JZHUD : UIViewController <ZXingDelegate>{
    ZXingWidgetController *widController;
    IBOutlet UIImageView* badge;
    IBOutlet UIImageView* bg;
    IBOutlet UILabel* blueTeamScore;
    IBOutlet UILabel* redTeamScore;
    char team;
    int time;
    IBOutlet UILabel* timer;
    
}

@property (nonatomic, retain) ZXingWidgetController*        widController;
@property (nonatomic, retain) IBOutlet  UIImageView*        badge;
@property (nonatomic, retain) IBOutlet  UIImageView*        bg;
@property (nonatomic, retain) IBOutlet  UIImageView*        movingBG;
@property (nonatomic        )           char                team;
@property (nonatomic        )           int                 time;
@property (nonatomic, retain) IBOutlet  UILabel*            timer;
@property (nonatomic, retain) IBOutlet  UILabel*            blueTeamScore;
@property (nonatomic, retain) IBOutlet  UILabel*            redTeamScore;
@property (nonatomic, retain) IBOutlet  UIView*             powerUpPanel;
@property (nonatomic, retain) IBOutlet  UIImageView*        bonus;
@property (nonatomic, retain) IBOutlet  UIImageView*        trim;
@property (nonatomic, retain) IBOutlet  UIImageView*        cogs;

@property (nonatomic, retain)           JZGlobalResources*  resources;


-(void)passJoinScan:(JZQRInfo*)i withResource:(JZGlobalResources*)r;
-(void)countdown;
-(void)endGame;
-(IBAction)scanButtonWasPressed;
-(IBAction)scanButtonWasReleased;
-(IBAction)showPowerUpPanel;
-(IBAction)dismissPowerUpPanel;

@end
