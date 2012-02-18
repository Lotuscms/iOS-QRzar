//
//  JZOneSecondBlocker.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZOneSecondBlocker : NSObject
@property bool blocker;

-(BOOL)check;
-(void)block;
-(void)unblock;
@end
