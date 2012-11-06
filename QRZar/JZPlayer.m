//
//  JZPlayer.m
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZPlayer.h"
#import "JZManagedObjectController.h"

static JZPlayer* singleton = nil;

@implementation JZPlayer

@synthesize team = _team;
@synthesize playerID = _playerID;
@synthesize name = _name;
@synthesize apiToken = _apiToken;
@synthesize game = _game;
@synthesize alive = _alive;

+(JZPlayer*)sharedInstance{
	
	if (singleton==nil) {
		singleton = [[JZPlayer alloc] init];
		[singleton setAlive:YES];
	}
	return singleton;
}

-(void)extendedSetAlive:(BOOL)alive{
	
	if (self.alive!=alive) {
		self.alive = alive;
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Alive Change" object:self];
	}
	
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
