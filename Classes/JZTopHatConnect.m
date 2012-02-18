//
//  JZTopHatConnect.m
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZTopHatConnect.h"
#import "SBJson.h"

@implementation JZTopHatConnect


//  Could be lumped together server side.

-(BOOL)isGameCurrentlyActive:(NSString*)gameID{
    return nil;
}

-(BOOL)isCodeAlreadyRegisteredOnActiveGame:(NSString*)gameID withCode:(NSString*)playerID{
    return nil;
}

-(BOOL)createGameWithGameID:(NSString*)gameID{
    return nil;
}

-(BOOL)joinGame:(NSString*)gameID withPlayerID:(NSString*)playerID;{
    return nil;
}




// In game calls

-(BOOL)isPlayerDeadForPlayerID:(NSString*)playerID inGameWithID:(NSString*)gameID{
    return nil;
}

-(BOOL)playerWithID:(NSString*)playerID hasKilledPlayerWithID:(NSString*)victimID{
    return nil;
}

-(NSDictionary*)getInGameInfoForPlayerWithID:(NSString*)playerID 
                                inGameWithID:(NSString*)gameID 
                                forLongitude:(double)longitude 
                                 forLatitude:(double)latitude 
                                withAccuracy:(double)accuracy{
    return nil;
}

@end
