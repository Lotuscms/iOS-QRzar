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
#import "JZGamePlayers.h"


@interface JZPlayer : NSObject{
	
	JZTeam* _team;
	NSString* _apiToken;
	NSString* _playerID;
	JZGamePlayers* _gamePlayer;
	JZGame* _game;
}

@property (nonatomic, retain) NSString* apiToken;
@property (nonatomic, retain) NSString* playerID;
@property (nonatomic, retain) JZTeam* team;
@property (nonatomic, retain) JZGame* game;
@property (nonatomic, retain) JZGamePlayers* gamePlayer;

+(JZPlayer*)sharedInstance;

+(void)destroy;

-(BOOL)alive;
-(void)setAlive:(BOOL)alive;


@end
