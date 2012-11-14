//
//  JZTeam.h
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZGame.h"


@interface JZTeam : NSObject{
	
	UIColor* _teamColor;
	int _teamScore;
	int _teamID;
	NSString* _referenceCode;
	NSString* _name;
	NSArray* _players;
}

@property (nonatomic, retain) UIColor* teamColor;
@property (nonatomic) int teamScore;
@property (nonatomic) int teamID;
@property (nonatomic, retain) NSString* referenceCode;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSArray* players;

-(id)initWithDictionary:(NSDictionary*)dictionary;

-(void)updatePlayersScoresAndLocationWithArray:(NSArray*)array;

@end
