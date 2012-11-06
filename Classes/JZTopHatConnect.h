//
//  JZTopHatConnect.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JZTopHatConnect : NSObject <NSStreamDelegate>

-(int)joinGameWithID:(NSString*)gameID;
-(int)revivePlayer:(NSString*)reviveCode;
-(int)playerHasKilledPlayerWithID:(NSString*)victimID;

-(int)updateAlive;
-(int)updateTeamScores;
-(int)updateLocation;

@end
