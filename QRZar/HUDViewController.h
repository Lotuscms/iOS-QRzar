//
//  HUDViewController.h
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "JZRadarViewController.h"

@interface HUDViewController : UIViewController<ZXingDelegate>{
	ZXingWidgetController* _widController;
	BOOL _scanPending;
	NSTimer* _loopTimer;
	UINavigationController* _radarView;
	BOOL continueScan;
}


@property (nonatomic, retain) ZXingWidgetController* widController;

@property (nonatomic, retain) IBOutlet UIView* tabBar;
@property (nonatomic, retain) IBOutlet UIView* topBar;

@property (nonatomic, retain) IBOutlet UILabel* leftTeamTitle;
@property (nonatomic, retain) IBOutlet UILabel* leftTeamScore;
@property (nonatomic, retain) IBOutlet UILabel* rightTeamTitle;
@property (nonatomic, retain) IBOutlet UILabel* rightTeamScore;
@property (nonatomic, retain) IBOutlet UILabel* clock;

@property (nonatomic, retain) IBOutlet UILabel* messageReadOut;

@property (nonatomic, retain) IBOutlet UIImageView* bloodSplatterOverlay;

@property (nonatomic, retain) IBOutlet UIButton* ranksButton;
@property (nonatomic, retain) IBOutlet UIButton* radarButton;
@property (nonatomic, retain) IBOutlet UIImageView* hLazer1;
@property (nonatomic, retain) IBOutlet UIImageView* hLazer2;
@property (nonatomic, retain) IBOutlet UIImageView* vLazer1;
@property (nonatomic, retain) IBOutlet UIImageView* vLazer2;

@property (nonatomic) BOOL scanPending;
@property (nonatomic, retain) NSTimer* loopTimer;

@property (nonatomic, retain) UINavigationController* radarView;

-(IBAction)startScan;

-(IBAction)stopScan;

-(IBAction)showRankings;

-(IBAction)showRadar;

@end
