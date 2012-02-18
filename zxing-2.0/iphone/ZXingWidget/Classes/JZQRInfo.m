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
    if([str characterAtIndex:0]=='Q'&&([str characterAtIndex:1]=='R'||[str characterAtIndex:1]=='B')&&[str length]==6){
        self = [super init];
        if (self) {
            
            gameID   = [NSString stringWithFormat:@"%i",(([str characterAtIndex:2]<<8)+[str characterAtIndex:3])];
            playerID = [NSString stringWithFormat:@"%i",(([str characterAtIndex:4]<<8)+[str characterAtIndex:5])];
        
            team = [str characterAtIndex:1];
            
        }
    
        return self;
    }
    
    return NULL;
}

@end
