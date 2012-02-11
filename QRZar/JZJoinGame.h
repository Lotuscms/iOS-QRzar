//
//  JZJoinGame.h
//  QRZar
//
//  Created by Conor Brady on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"


@interface JZJoinGame : UIViewController <ZXingDelegate>{
    ZXingWidgetController *widController;
}

@property (nonatomic, retain) IBOutlet UIImageView* top;
@property (nonatomic, retain) IBOutlet UIImageView* btm;
@property (nonatomic, retain) ZXingWidgetController *widController;

-(IBAction)openSliders;
-(IBAction)closeSliders;
-(IBAction)info;
-(IBAction)rank;

@end
