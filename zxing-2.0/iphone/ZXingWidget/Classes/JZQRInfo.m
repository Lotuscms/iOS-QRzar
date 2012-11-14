//
//  JZQRInfo.m
//  QRZar
//
//  Created by Conor Brady on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZQRInfo.h"

@implementation JZQRInfo

@synthesize rawResult = _rawResult;

- (id)init:(NSString*)str {
    
        self = [super init];
        if (self) {
			[self setRawResult:str];
        }
    
        return self;
    
}

@end
