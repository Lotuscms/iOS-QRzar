//
//  JZManagedObjectController.h
//  QRZar
//
//  Created by Conor Brady on 05/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface JZManagedObjectController : NSObject{
	
	NSManagedObjectContext* _managedObjectContext;
	NSManagedObject* _user;
	NSManagedObject* _game;
}

@property (nonatomic, retain) NSManagedObject* user;
@property (nonatomic, retain) NSManagedObject* game;
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;

+(JZManagedObjectController*)sharedInstance;

-(void)setApiToken:(NSString*)apiToken;
-(NSString*)apiToken;

-(void)setGameID:(NSString*)gameID;
-(NSString*)gameID;

-(void)setPlayerID:(NSString*)playerID;
-(NSString*)playerID;

-(void)setGameEndTime:(NSDate*)endTime;
-(NSDate*)endTime;
-(BOOL)isGameOver;


@end
