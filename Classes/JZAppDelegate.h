//
//  JZAppDelegate.h
//  QRZar
//
//  Created by Conor Brady on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZJoinGame.h"

@interface JZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) JZJoinGame *joinGame;

@end
