//
//  JZGamePlayers.m
//  QRZar
//
//  Created by Conor Brady on 06/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZGamePlayers.h"

@implementation JZGamePlayers

@synthesize score = _score;
@synthesize team = _team;
@synthesize playerID = _playerID;
@synthesize location = _location;
@synthesize name = _name;
@synthesize alive = _alive;
@synthesize visible = _visible;

-(id)initWithDictionary:(NSDictionary *)dictionary andTeam:(JZTeam *)team{
	
	self = [super init];
	if (self) {
		[self setTeam:team];
		[self setPlayerID:[[dictionary valueForKey:@"id"] intValue]];
		[self setName:[dictionary valueForKey:@"name"]];
		[self updateWithDictionary:dictionary];
	}
	return self;
}

-(void)updateWithDictionary:(NSDictionary *)dictionary{
	
	[self setScore:[[dictionary valueForKey:@"score"] intValue]];
	[self setLocation:[[CLLocation alloc] initWithLatitude:[[dictionary valueForKey:@"lat"] doubleValue] longitude:[[dictionary valueForKey:@"lon"] doubleValue]]];
	[self setAlive:[[dictionary valueForKey:@"alive"] boolValue]];
	if ([dictionary valueForKey:@"visible"]!=NULL) {
		[self setVisible:[[dictionary valueForKey:@"visible"] boolValue]];
	}else{
		[self setVisible:YES];
	}
}

@end
