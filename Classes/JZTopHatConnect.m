//
//  JZTopHatConnect.m
//  QRZar
//
//  Created by Conor Brady on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZTopHatConnect.h"
#import "SBJson.h"
#import "JZPlayer.h"
#import "JZGlobalResources.h"
#import "JZManagedObjectController.h"

NSString* server = @"http://qrzar.com:443/";

@interface JZTopHatConnect (PrivateMethods) 

-(int) errorHandlerWithResponse:(NSJSONSerialization*)response error:(NSError*)error;
-(NSJSONSerialization*) getJSONFromServerWithPath:(NSString*)path method:(NSString*)method body:(NSString*)body error:(NSError**)err withTimeOut:(int)timeOut;

@end

@implementation JZTopHatConnect


- (id)init {
	
    self = [super init];
    if (self) {
		if (![[JZPlayer sharedInstance] apiToken]) {
			
			NSError* err = nil;
			NSJSONSerialization* json = [self getJSONFromServerWithPath:[NSString stringWithFormat:@"%@apitokens/", server] 
																 method:@"POST" 
																   body:@"data={}" 
																  error:&err
															withTimeOut:2
										 ];
			
			if ([self errorHandlerWithResponse:json error:err]!=200) {
				
				NSLog(@"error initializing tophatconnect:%@",[json valueForKey:@"error_message"]);
				
				return NULL;
				
			}else{
				
				[[JZPlayer sharedInstance] setApiToken:[json valueForKey:@"apitoken"]];
			}
		}
        
    }
    return self;
}

-(int)updatePlayersOnTeam:(JZTeam *)team{
	
	NSError* err = nil;
	
	NSJSONSerialization* json = [self getJSONFromServerWithPath:[NSString stringWithFormat:@"%@teams/%i?apitoken=%@&depth=2", server,[team teamID],[[JZPlayer sharedInstance] apiToken]] 
														 method:@"GET" 
														   body:NULL 
														  error:&err
													withTimeOut:2
								 ];
	int errorCode = [self errorHandlerWithResponse:json error:err];
	if (errorCode==200) {
		[team updatePlayersScoresAndLocationWithArray:[json valueForKey:@"players"]];
	}
	return errorCode;
}

-(int)resumeStoredGame{
	
	NSError* err = nil;
	
	NSJSONSerialization* json = [self getJSONFromServerWithPath:[NSString stringWithFormat:@"%@games/%@?apitoken=%@&depth=4", server,[[JZManagedObjectController sharedInstance] gameID],[[JZPlayer sharedInstance] apiToken]] 
														 method:@"GET" 
														   body:NULL 
														  error:&err
													withTimeOut:2
								 ];
	
	if (!err&&![json valueForKey:@"error_code"]) {
		
//		NSLog(@"%@",[json JSONRepresentation]);
		
		[[JZPlayer sharedInstance] setPlayerID:[[JZManagedObjectController sharedInstance] playerID]];
		
		[[JZPlayer sharedInstance] setGame:[[JZGame alloc] initWithDictionary:(NSDictionary*)json]];
		
		NSArray* teams = [[[JZPlayer sharedInstance] game] teams];
		
		for (int i = 0; i<[teams count]; i++) {
			if ([[[JZManagedObjectController sharedInstance] teamID] intValue]==[(JZTeam*)[teams objectAtIndex:i] teamID]) {
				[[JZPlayer sharedInstance] setTeam:[teams objectAtIndex:i]];
			}
		}
	}
	return [self errorHandlerWithResponse:json error:err];
}

-(int)joinGameWithID:(NSString *)gameID andQRCode:(NSString *)qrCode{
	
	NSError* err = nil;
	
	NSJSONSerialization* json = [self getJSONFromServerWithPath:[NSString stringWithFormat:@"%@games/%@?apitoken=%@&depth=1", server, gameID,[[JZPlayer sharedInstance] apiToken]] 
														 method:@"GET" 
														   body:NULL
														  error:&err
													withTimeOut:5
								 ];
	int errorCode = [self errorHandlerWithResponse:json error:err];
	if (errorCode==200) {
		
		NSString* endTime = [json valueForKey:@"end_time"];
		
		NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		[dateFormatter setLocale:[NSLocale systemLocale]];
		NSDate* endTimeDate = [dateFormatter dateFromString:endTime];
		[[JZManagedObjectController sharedInstance] setGameEndTime:endTimeDate];
		
		if ([endTimeDate timeIntervalSinceNow]<0) {
			
			return 404;
			
		}else{
			
			NSString* name = [[[[UIDevice currentDevice] name] componentsSeparatedByString:@"’"] componentsJoinedByString:@""];
			
			json = [self getJSONFromServerWithPath:[NSString stringWithFormat:@"%@players/?apitoken=%@&depth=1", server,[[JZPlayer sharedInstance] apiToken]] 
											method:@"POST" 
											  body:[NSString stringWithFormat:@"data={\"name\":\"%@\",\"game\":{\"id\":\"%@\"},\"qrcode\":\"%@\"}",name, gameID, qrCode] 
											 error:&err
									   withTimeOut:5
					];
			
			if (!err&&![json valueForKey:@"error_code"]) {
				NSLog(@"%@",[json JSONRepresentation]);
				
				[[JZManagedObjectController sharedInstance] setPlayerID:[(NSNumber*)[json valueForKey:@"id"]stringValue]];
				
				[[JZManagedObjectController sharedInstance] setGameID:[[[[json valueForKey:@"team"] valueForKey:@"game"] valueForKey:@"id"] stringValue]];
				
				[[JZManagedObjectController sharedInstance] setTeamID:[[json valueForKey:@"team"] valueForKey:@"id"]];
				
				[[NSNotificationCenter defaultCenter] postNotificationName:@"Game Joined" object:self];
				
				return [self resumeStoredGame];
			}
			return [self errorHandlerWithResponse:json error:err];
		}
	}else{
		return errorCode;
	}
	
}


-(int)playerHasKilledPlayerWithID:(NSString*)victimID{
    
    
	NSError* err = nil;
	
	NSJSONSerialization* json = [self getJSONFromServerWithPath:[NSString stringWithFormat:@"%@kills/?apitoken=%@", server,[[JZPlayer sharedInstance] apiToken]] 
														 method:@"POST" 
														   body:[NSString stringWithFormat:@"data={\"killer\": {\"id\": %@},\"victim_qrcode\": \"%@\" }",[[JZPlayer sharedInstance] playerID],victimID] 
														  error:&err
													withTimeOut:4
								 ];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Kill Message" object:self userInfo:(NSDictionary*)json];
	return [self errorHandlerWithResponse:json error:err];
}




-(int)updateLocation{
    
	NSError* err = nil;
	NSJSONSerialization* json = [self getJSONFromServerWithPath:[NSString stringWithFormat:@"%@players/?apitoken=%@", server,[[JZPlayer sharedInstance] apiToken]] 
														 method:@"PUT" 
														   body:[NSString stringWithFormat:@"data={\"longitude\": %f, \"latitude\": %f,\"id\":%@}",
																 [[[JZGlobalResources sharedInstance] locationManager] getLong], 
																 [[[JZGlobalResources sharedInstance] locationManager] getLat],
																 [[JZPlayer sharedInstance] playerID]] 
														  error:&err
													withTimeOut:2
								 ];
	
	return [self errorHandlerWithResponse:json error:err];
}

-(int)revivePlayer:(NSString *)reviveCode{
    
    NSError* err = nil;
	NSJSONSerialization* json = [self getJSONFromServerWithPath:[NSString stringWithFormat:@"%@players/?apitoken=%@", server,[[JZPlayer sharedInstance] apiToken]] 
														 method:@"PUT" 
														   body:[NSString stringWithFormat:@"data={\"respawn_code\": \"%@\",\"id\":%@}",reviveCode,[[JZPlayer sharedInstance] playerID]] 
														  error:&err
													withTimeOut:0
								 ];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Respawn Message" object:self userInfo:(NSDictionary*)json];
	return [self errorHandlerWithResponse:json error:err];

}



-(int)errorHandlerWithResponse:(NSJSONSerialization *)response error:(NSError *)error{
	if(error!=nil){
		NSLog(@"error:%@",error.description);
		return -1;
	}else if (response==nil) {
		return 0;
	}else if ([response valueForKey:@"error_code"]) {
		NSLog(@"response:%@",[response valueForKey:@"error_code"]);
		return [[response valueForKey:@"error_code"] intValue];
	}else{
		return 200;
	}
}

-(NSJSONSerialization*)getJSONFromServerWithPath:(NSString *)path method:(NSString *)method body:(NSString *)body error:(NSError *__autoreleasing *)err withTimeOut:(int)timeOut{
	
//	NSLog(@"%@",path);
//	NSLog(@"%@",method);
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
	
	
	if (timeOut>0) {
		[request setTimeoutInterval:timeOut];
	}
	
	[request setHTTPMethod:method];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
	
	
	if (body!=NULL) {
		
//		NSLog(@"%@",body);
		NSData* content = [body dataUsingEncoding:NSASCIIStringEncoding];
		[request setHTTPBody:content];
	}
	
	NSData * response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:err];
	if (response!=nil) {
		return [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
	}else{
		return NULL;
	}
	
}

@end
