//
//  JZTopHatConnect.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZTeam.h"

@interface JZTopHatConnect : NSObject <NSStreamDelegate>

-(int)joinGameWithID:(NSString*)gameID andQRCode:(NSString*)qrCode;
-(int)resumeStoredGame;
-(int)revivePlayer:(NSString*)reviveCode;
-(int)playerHasKilledPlayerWithID:(NSString*)victimID;


-(int)updateLocation;
-(int)updatePlayersOnTeam:(JZTeam*)team;

@end
