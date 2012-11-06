//
//  JZTeam.m
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZTeam.h"

@implementation JZTeam

@synthesize teamID = _teamID;
@synthesize teamColor = _teamColor;
@synthesize teamScore = _teamScore;
@synthesize name =_name;
@synthesize referenceCode = _referenceCode;

-(id)initWithDictionary:(NSDictionary *)dictionary{
	self = [super init];
	if (self) {
		NSDictionary* colorTranslation = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], @"R", [UIColor blueColor], @"B", [UIColor greenColor],@"G", [UIColor yellowColor],@"Y", nil];
		[self setReferenceCode:[dictionary objectForKey:@"reference_code"]];
		[self setTeamColor:[colorTranslation objectForKey:[self referenceCode]]];
		[self setTeamScore:0];
		[self setTeamID:[[dictionary objectForKey:@"id"] intValue]];
		[self setName:[dictionary objectForKey:@"name"]];
	}
	return self;
}

-(void)extendedSetTeamScore:(int)teamScore{
	if (self.teamScore!=teamScore) {
		self.teamScore = teamScore;
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Team Score Change" object:NULL];
	}
}

@end
