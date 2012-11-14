//
//  JZGamePlayers.h
//  QRZar
//
//  Created by Conor Brady on 06/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZTeam.h"
#import <CoreLocation/CoreLocation.h>

@interface JZGamePlayers : NSObject{
	
	JZTeam* _team;
	int _playerID;
	NSString* _name;
	CLLocation* _location;
	int _score;
	BOOL _alive;
	BOOL _visible;
}

@property (nonatomic, retain) JZTeam* team;
@property                     int playerID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) CLLocation* location;
@property					  int score;
@property					  BOOL alive;
@property					  BOOL visible;

-(id)initWithDictionary:(NSDictionary*)dictionary andTeam:(JZTeam*)team;

-(void)updateWithDictionary:(NSDictionary*)dictionary;

@end
