//
//  JZGame.m
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZGame.h"
#import "JZManagedObjectController.h"


@implementation JZGame

@synthesize teams = _teams;
@synthesize gameID = _gameID;
@synthesize endTime = _endTime;
@synthesize started = _started;
@synthesize gameName = _gameName;
@synthesize players = _players;

-(id)initWithDictionary:(NSDictionary *)dictionary{
	
	self = [super init];
	if (self) {
		
		[self setStarted:(BOOL)[dictionary objectForKey:@"started"]];
		[self setGameID:[(NSNumber*)[dictionary objectForKey:@"id"] stringValue]];
		[[JZManagedObjectController sharedInstance] setGameID:[(NSNumber*)[dictionary objectForKey:@"id"] stringValue]];
		[self setGameName:[dictionary objectForKey:@"name"]];
		
		NSString* endTime = [dictionary objectForKey:@"end_time"];
		
		NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		[dateFormatter setLocale:[NSLocale systemLocale]];
		[self setEndTime:[dateFormatter dateFromString:endTime]];
		[[JZManagedObjectController sharedInstance] setGameEndTime:[dateFormatter dateFromString:endTime]];
		
		NSMutableArray* teamObjects = [[NSMutableArray alloc] initWithCapacity:2];
		NSArray* teams = [dictionary objectForKey:@"teams"];
		for (int i = 0; i<[teams count]; i++) {
			[teamObjects addObject:[[JZTeam alloc] initWithDictionary:[teams objectAtIndex:i]]];
		}
		[self setTeams:teamObjects];
	}
	return self;
}

-(JZTeam*)getTeamAtRank:(int)rank{
	
	[self setTeams:[[self teams] sortedArrayUsingComparator:^NSComparisonResult(JZTeam* obj1, JZTeam* obj2) {
		if ([obj1 teamScore] > [obj2 teamScore]) {
			return (NSComparisonResult)NSOrderedAscending;
		}else if([obj1 teamScore] < [obj2 teamScore]){
			return (NSComparisonResult)NSOrderedDescending;
		}else{
			return (NSComparisonResult)NSOrderedSame;
		}
				   
	}]];
	return (JZTeam*)[[self teams] objectAtIndex:rank-1];
}


@end
