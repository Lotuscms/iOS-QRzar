//
//  JZQRInfo.h
//  QRZar
//
//  Created by Conor Brady on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZQRInfo : NSObject {

	NSString* _rawResult;
    
}

-(id)init:(NSString*)str;

@property (nonatomic, retain) NSString* rawResult;

@end
