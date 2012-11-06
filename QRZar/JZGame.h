//
//  JZGame.h
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZTeam.h"

@interface JZGame : NSObject{
	
	NSDate* _endTime;
	NSString* _gameID;
	NSArray* _teams;
	NSArray* _players;
	BOOL _started;
	NSString* _gameName;
}

@property (nonatomic, retain) NSDate* endTime;
@property (nonatomic, retain) NSString* gameID;
@property (nonatomic, retain) NSArray* teams;
@property (nonatomic, retain) NSString* gameName;
@property					  BOOL started;
@property (nonatomic, retain) NSArray* players;

-(id)initWithDictionary:(NSDictionary*)dictionary;

-(id)getTeamAtRank:(int)rank;

@end
