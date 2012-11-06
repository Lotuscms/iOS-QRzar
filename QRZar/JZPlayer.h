//
//  JZPlayer.h
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZTeam.h"
#import "JZGame.h"


@interface JZPlayer : NSObject{
	NSString* _name;
	NSString* _qrCode;
	JZTeam* _team;
	NSString* _apiToken;
	NSString* _playerID;
	JZGame* _game;
	BOOL _alive;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* qrCode;
@property (nonatomic, retain) NSString* apiToken;
@property (nonatomic, retain) NSString* playerID;
@property (nonatomic, retain) JZTeam* team;
@property (nonatomic, retain) JZGame* game;
@property (nonatomic, assign) BOOL alive;

+(JZPlayer*)sharedInstance;

-(void)extendedSetAlive:(BOOL)alive;

@end
