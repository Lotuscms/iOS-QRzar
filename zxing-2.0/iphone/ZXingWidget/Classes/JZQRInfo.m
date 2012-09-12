//
//  JZQRInfo.m
//  QRZar
//
//  Created by Conor Brady on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZQRInfo.h"

@implementation JZQRInfo

@synthesize gameID, playerID, team;

- (id)init:(NSString*)str {
    if(([str characterAtIndex:0]=='Y'||[str characterAtIndex:0]=='B'||[str characterAtIndex:0]=='R'||[str characterAtIndex:0]=='G')&&[str length]==6){
        self = [super init];
        if (self) {
			
			int digitOne = [str characterAtIndex:1]<<16;
			int digitTwo = [str characterAtIndex:2]<<8;
			int digitThree = [str characterAtIndex:3];
            
            gameID   = [NSString stringWithFormat:@"%i",(digitOne+digitTwo+digitThree)];
            playerID = [NSString stringWithFormat:@"%@-%c-%i",gameID,[str characterAtIndex:0],(([str characterAtIndex:4]<<8)+[str characterAtIndex:5])];
        
            team = [str characterAtIndex:0];
            
        }
    
        return self;
    }
    
    return NULL;
}

@end
