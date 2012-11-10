//
//  JZPlayer.m
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZPlayer.h"
#import "JZManagedObjectController.h"
#import "JZGamePlayers.h"

static JZPlayer* singleton = nil;

@implementation JZPlayer

@synthesize team = _team;
@synthesize playerID = _playerID;
@synthesize apiToken = _apiToken;
@synthesize gamePlayer = _gamePlayer;

@synthesize game = _game;

+(JZPlayer*)sharedInstance{
	
	if (singleton==nil) {
		singleton = [[JZPlayer alloc] init];
		[singleton setAlive:YES];
		
	}
	return singleton;
}
+(void)destroy{
	singleton = nil;
}

-(void)setAlive:(BOOL)alive{
	
	[[self gamePlayer] setAlive:alive];
}

-(JZGamePlayers*) gamePlayer{
	if (_gamePlayer==nil) {
		for (int i = 0; i<[[[self team] players] count]; i++) {
			if ([[self playerID] intValue] == [(JZGamePlayers*)[[[self team] players] objectAtIndex:i] playerID]) {
				_gamePlayer = (JZGamePlayers*)[[[self team] players] objectAtIndex:i];
			}
		}
	}
	return _gamePlayer;
}

-(BOOL)alive{
	
	return [[self gamePlayer] alive];
}

-(void)setPlayerID:(NSString *)playerID{
	_playerID = playerID;
	[[JZManagedObjectController sharedInstance] setPlayerID:playerID];
}

-(void)setApiToken:(NSString *)apiToken{
	
	[[JZManagedObjectController sharedInstance] setApiToken:apiToken];
}

-(NSString*)apiToken{
	
	return [[JZManagedObjectController sharedInstance] apiToken];
}


@end
