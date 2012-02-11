//
//  JZHUD.h
//  QRZar
//
//  Created by Conor Brady on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"

@interface JZHUD : UIViewController <ZXingDelegate>{
    ZXingWidgetController *widController;
}

@property (nonatomic, retain) ZXingWidgetController *widController;

-(IBAction)scanButtonWasPressed;
-(IBAction)scanButtonWasReleased;

@end
