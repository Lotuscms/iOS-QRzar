//
//  JZTeam.m
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZTeam.h"
#import "JZGamePlayers.h"



@implementation JZTeam

@synthesize teamID = _teamID;
@synthesize teamColor = _teamColor;
@synthesize teamScore = _teamScore;
@synthesize name =_name;
@synthesize referenceCode = _referenceCode;
@synthesize players = _players;

-(id)initWithDictionary:(NSDictionary *)dictionary{
	self = [super init];
	if (self) {
		NSDictionary* colorTranslation = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], @"R", [UIColor blueColor], @"B", [UIColor greenColor],@"G", [UIColor yellowColor],@"Y", nil];
		[self setReferenceCode:[dictionary objectForKey:@"reference_code"]];
		[self setTeamColor:[colorTranslation objectForKey:[self referenceCode]]];
		[self setTeamScore:0];
		[self setTeamID:[[dictionary objectForKey:@"id"] intValue]];
		[self setName:[dictionary objectForKey:@"name"]];
		
		NSArray* players = [dictionary valueForKey:@"players"];
		
		NSMutableArray* playersOnTeam = [[NSMutableArray alloc] init];
		for (int j = 0; j<[players count]; j++) {
			[playersOnTeam addObject:[[JZGamePlayers alloc] initWithDictionary:[players objectAtIndex:j] andTeam:self]];
		}
		[self setPlayers:playersOnTeam];
		
	}
	return self;
}

-(int)teamScore{
	int sum =0;
	for (int i = 0; i<[[self players] count]; i++) {
		sum += [[[self players] objectAtIndex:i] score];
	}
	return sum;
}

-(void)updatePlayersScoresAndLocationWithArray:(NSArray *)array{
	
	array = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
		if ([[obj1 valueForKey:@"id"] intValue] > [[obj2 valueForKey:@"id"] intValue]) {
			return (NSComparisonResult)NSOrderedDescending;
		}else if([[obj1 valueForKey:@"id"] intValue] < [[obj2 valueForKey:@"id"] intValue]){
			return (NSComparisonResult)NSOrderedAscending;
		}else{
			return (NSComparisonResult)NSOrderedSame;
		}
	}];
	NSMutableArray* players = [[[self players] sortedArrayUsingComparator:^NSComparisonResult(JZGamePlayers* obj1, JZGamePlayers* obj2) {
		if ([obj1 playerID] > [obj2 playerID]) {
			return (NSComparisonResult)NSOrderedDescending;
		}else if([obj1 playerID] < [obj2 playerID]){
			return (NSComparisonResult)NSOrderedAscending;
		}else{
			return (NSComparisonResult)NSOrderedSame;
		}
	}] mutableCopy];
	
	for (int i = 0; i<[array count]; i++) {
		if (i<[players count]) {
			
			while (i<[players count]&&[[[array objectAtIndex:i] valueForKey:@"id"] intValue]!=[[players objectAtIndex:i] playerID]) {
				
				[players removeObjectAtIndex:i];
			}
			if (i<[players count]) {
				[[players objectAtIndex:i] updateWithDictionary:[array objectAtIndex:i]];
			}
		}else{
			
			[players addObject:[[JZGamePlayers alloc] initWithDictionary:[array objectAtIndex:i] andTeam:self]];
		}
	}
	[self setPlayers:players];
}

@end
