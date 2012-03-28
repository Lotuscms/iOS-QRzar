//
//  JZTopHatConnect.h
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JZTopHatConnect : NSObject <NSStreamDelegate>

@property (nonatomic, retain) NSString* playerID;

@property (nonatomic, retain) NSInputStream*  inputStream;
@property (nonatomic, retain) NSOutputStream* outputStream;



- (id)initWithPlayerID:(NSString*)playerID;




// In game calls


-(BOOL)playerHasKilledPlayerWithID:(NSString*)victimID;

-(NSDictionary*)getInGameInfoForPlayerWithLongitude:(double)longitude 
                                        forLatitude:(double)latitude 
                                       withAccuracy:(double)accuracy;



-(BOOL)revivePlayer;

@end
