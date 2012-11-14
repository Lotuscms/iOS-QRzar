//
//  RankingViewController.h
//  QRZar
//
//  Created by Conor Brady on 06/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUDViewController.h"

@interface RankingViewController : UITableViewController {
	BOOL initialLaunch;
	HUDViewController* _hud;
}

@property (nonatomic, retain) HUDViewController* hud;

-(void)dismiss;
-(void)terminate;

@end
