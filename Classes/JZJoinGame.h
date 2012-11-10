//
//  JZJoinGame.h
//  QRZar
//
//  Created by Conor Brady on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "JZGlobalResources.h"



typedef enum{
	
	kScanGame,
	kScanPlayer,
	kJoinGame,
	kResumeGame

}ButtonTags;

typedef enum{

	kJoin,
	kConnect

}RefreshState;

@interface JZJoinGame : UIViewController <ZXingDelegate, UIAlertViewDelegate>{
    ZXingWidgetController *_widController;
	NSString* _gameCode;
	NSString* _qrCode;
	
}

@property (nonatomic, retain) ZXingWidgetController *widController;
@property (nonatomic, retain) IBOutlet UIView* cover;
@property (nonatomic, retain) IBOutlet UIButton* gameScanButton;
@property (nonatomic, retain) IBOutlet UIButton* playerScanButton;
@property (nonatomic, retain) IBOutlet UILabel* gameReadLabel;
@property (nonatomic, retain) IBOutlet UILabel* playerReadLabel;
@property (nonatomic, retain) IBOutlet UIView* joinGameView;
@property (nonatomic, retain) IBOutlet UIView* startSlider;
@property (nonatomic, retain) IBOutlet UIButton* joinGameButton;
@property (nonatomic, retain) IBOutlet UIView* resumeGameView;
@property (nonatomic, retain) IBOutlet UIButton* resumeGameButton;
@property (nonatomic, retain) IBOutlet UILabel* feedbackLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* indicator;
@property (nonatomic, retain) IBOutlet UILabel* contactingServer;
@property (nonatomic, retain) IBOutlet UIButton* networkErrorOKButton;
@property (nonatomic, retain) IBOutlet UIButton* networkRefreshButton;
@property (nonatomic, retain) IBOutlet UIImageView* lowerBackground;
@property					  ButtonTags senderButton;
@property					  RefreshState refreshState;
@property					  ButtonTags joinState;
@property (nonatomic, retain) NSString* gameCode;
@property (nonatomic, retain) NSString* qrCode;


-(IBAction)startScan:(id)sender;
-(IBAction)stopScan:(id)sender;
-(IBAction)startGame:(id)sender;
-(IBAction)slide;
-(IBAction)refreshNetwork;

@end
