//
//  JZManagedObjectController.m
//  QRZar
//
//  Created by Conor Brady on 05/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZManagedObjectController.h"

static JZManagedObjectController* singleton = nil;

@implementation JZManagedObjectController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize user = _user;
@synthesize game = _game;

+(JZManagedObjectController*)sharedInstance{
	if (singleton!=nil) {
		return singleton;
	}
	singleton = [[JZManagedObjectController alloc] init];
	if ([[[singleton managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"User"] error:nil]count]>0) {
		[singleton setUser:[[[singleton managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"User"] error:nil] objectAtIndex:0]];
	}
	if ([[[singleton managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Game"] error:nil]count]>0) {
		[singleton setGame:[[[singleton managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Game"] error:nil] objectAtIndex:0]];
	}
	
	
	return singleton;
}

-(void)setPlayerID:(NSString *)playerID{
	
	[[self game] setValue:playerID forKey:@"playerID"];
}

-(NSManagedObject*)game{
	
	if (_game==nil) {
		
		if ([[[self managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Game"] error:nil]count]>0) {
			
			[self setGame:[[[self managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Game"] error:nil] objectAtIndex:0]];
			
		}else{
			
			NSEntityDescription* userEntity = [NSEntityDescription entityForName:@"Game" 
														  inManagedObjectContext:[self managedObjectContext]];
			
			[self setGame:[[NSManagedObject alloc] initWithEntity:userEntity 
								   insertIntoManagedObjectContext:[self managedObjectContext]]];
		}
	}
	return _game;
}

-(NSManagedObject*)user{
	if (_user==nil) {
		if ([[[self managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"User"] error:nil]count]>0) {
			[self setUser:[[[singleton managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"User"] error:nil] objectAtIndex:0]];
		}else{
			NSEntityDescription* userEntity = [NSEntityDescription entityForName:@"User" 
														  inManagedObjectContext:[self managedObjectContext]];
			
			[self setUser:[[NSManagedObject alloc] initWithEntity:userEntity 
								   insertIntoManagedObjectContext:[self managedObjectContext]]];
		}
	}
	return _user;
}

-(NSString*)playerID{
	
	return [[self game] valueForKey:@"playerID"];
}

-(void)setGameID:(NSString *)gameID{
	
	[[self game] setValue:gameID forKey:@"gameID"];
}

-(NSString*)gameID{
	
	return [[self game] valueForKey:@"gameID"];
}

-(void)setGameEndTime:(NSDate *)endTime{
	
	[[self game] setValue:endTime forKey:@"endTime"];
}

-(NSDate*)endTime{
	return [[self game] valueForKey:@"endTime"];
}

-(BOOL)isGameOver{
	if ([self endTime] == nil) {
		return true;
	}
	NSLog(@"endtime:%@",[[self game] valueForKey:@"endTime"]);
	return [(NSDate*)[[self game] valueForKey:@"endTime"] compare:[NSDate date]]==NSOrderedAscending;
}

-(void)setApiToken:(NSString *)apiToken{
	
	[[self user] setValue:apiToken forKey:@"apiToken"];
	
}

-(NSString*)apiToken{
	
	return [[self user] valueForKey:@"apiToken"];
}

-(void)setTeamID:(NSNumber*)teamID{
	[[self game] setValue:teamID forKey:@"teamID"];
}

-(NSNumber*)teamID{
	return [[self game] valueForKey:@"teamID"];
}

-(NSManagedObjectContext*)managedObjectContext{
	
	if (_managedObjectContext) {
		return _managedObjectContext;
	}
	
	NSURL* prePath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
	NSString *STORE_FILENAME = @"qrzar.qrz";
	
    NSURL *url = [prePath URLByAppendingPathComponent:STORE_FILENAME];
	if (![url isFileURL]) {
		[[NSFileManager defaultManager] createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:Nil];
	}
	
	
	NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
	
	NSString *STORE_TYPE = NSBinaryStoreType;
	NSError *error;
	
    if ([coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:nil error:&error] == nil) {
		
        NSLog(@"Store Configuration Failure\n%@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
		
		return NULL;
		
    }else{
		
		[self setManagedObjectContext:[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType]];
		[_managedObjectContext setPersistentStoreCoordinator:coordinator];
		
		return _managedObjectContext;
	}
}
@end
