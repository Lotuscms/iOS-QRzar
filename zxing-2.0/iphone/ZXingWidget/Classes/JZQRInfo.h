//
//  JZQRInfo.h
//  QRZar
//
//  Created by Conor Brady on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZQRInfo : NSObject {
    char team;
    NSString* gameID;
    NSString* playerID;
    
}

-(id)init:(NSString*)str;

@property (nonatomic) char team;
@property (nonatomic,retain) NSString* gameID;
@property (nonatomic,retain) NSString* playerID;

@end
