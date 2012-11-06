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
	NSString* _playerID;
	NSString* _name;
	CLLocation* _location;
	int _score;
}

@property (nonatomic, retain) JZTeam* team;
@property (nonatomic, retain) NSString* playerID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) CLLocation* location;
@property					  int score;

@end
