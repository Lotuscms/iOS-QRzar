//
//  JZTopHatConnect.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JZTopHatConnect : NSObject



//  Could be lumped together server side.

-(BOOL)isGameCurrentlyActive:(NSString*)gameID;

-(BOOL)isCodeAlreadyRegisteredOnActiveGame:(NSString*)gameID withCode:(NSString*)playerID;

-(BOOL)createGameWithGameID:(NSString*)gameID;

-(BOOL)joinGame:(NSString*)gameID withPlayerID:(NSString*)playerID;




// In game calls

-(BOOL)isPlayerDeadForPlayerID:(NSString*)playerID inGameWithID:(NSString*)gameID;

-(BOOL)playerWithID:(NSString*)playerID hasKilledPlayerWithID:(NSString*)victimID;

-(NSDictionary*)getInGameInfoForPlayerWithID:(NSString*)playerID 
                                inGameWithID:(NSString*)gameID 
                                forLongitude:(double)longitude 
                                 forLatitude:(double)latitude 
                                withAccuracy:(double)accuracy;

@end
