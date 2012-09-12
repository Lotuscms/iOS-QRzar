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

@synthesize playerID, inputStream, outputStream;

//  Could be lumped together server side.

- (id)initWithPlayerID:(NSString*)_playerID {
    self = [super init];
    if (self) {
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        // Chancing my arm but sockets will be needed
        
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"tophat.ie", 7896, &readStream, &writeStream);
        inputStream = (__bridge NSInputStream *)readStream;
        outputStream = (__bridge NSOutputStream *)writeStream;
        
        [inputStream setDelegate:self];
        [outputStream setDelegate:self];
        
        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        playerID = _playerID;
        
        /*
		 Need json file containing current game time, and team scores 
		*/
		
		// TODO handle json file.
        
    }
    return self;
}

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
            
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
			break;
            
		case NSStreamEventHasBytesAvailable:
            if (aStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output) {
                            NSLog(@"server said: %@", output);
                        }
                    }
                }
            }
			break;			
            
		case NSStreamEventErrorOccurred:
			NSLog(@"Can not connect to the host!");
			break;
            
		case NSStreamEventEndEncountered:
			break;
            
		default:
			NSLog(@"Unknown event");
	}
}



// In game calls

-(BOOL)isPlayerDead{
    
    // check if the player is dead if he is call the revive player method after a set time / returns to base
    
    return true;
}

-(BOOL)playerHasKilledPlayerWithID:(NSString*)victimID{
    
    if ([[[playerID componentsSeparatedByString:@"-"] objectAtIndex:1] isEqualToString:[[victimID componentsSeparatedByString:@"-"] objectAtIndex:1]]) {
        
        // api call for the kill
        // return true if kill is validated 
        // do we allow friendly fire??
        
    }
        
    return false;
}


-(NSDictionary*)getInGameInfoForPlayerWithLongitude:(double)longitude 
                                        forLatitude:(double)latitude 
                                       withAccuracy:(double)accuracy{
    
    // gets dictionary of updated info for game i.e. team scores, time remaining
    
    return nil;
}

-(BOOL)revivePlayer{
    
    // ask the server to revive the player
    
    return true;
}

@end
