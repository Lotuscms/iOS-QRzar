//
//  JZRadarView.m
//  QRZar
//
//  Created by Conor Brady on 08/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
#import "JZRadarView.h"
#import "JZGamePlayers.h"
#import "JZPlayer.h"

#define RING_NUMBER	4


@interface JZRadarView (PrivateMethods)

-(CGPoint*)getRadarPointForPlayer:(JZGamePlayers*)player;

@end

@implementation JZRadarView

@synthesize scalingFactor = _scalingFactor;



-(id)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setScalingFactor:77700];
	}
	return self;
}



- (void)drawRect:(CGRect)rect
{
	CGFloat playerDotRadius = 10;
    CGPoint origin = CGPointMake(rect.size.width/2, rect.size.height/2);
	CGFloat radius = rect.size.width/2-20;
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
	CGContextFillRect(context, rect);
	
	CGContextSetStrokeColorWithColor(context, [[UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchBrightBackground"]] CGColor]);
	CGContextSetLineWidth(context, 1);
	
	for (int i = 1; i<RING_NUMBER; i++) {
		CGContextStrokeEllipseInRect(context, CGRectMake(origin.x-(radius*i/RING_NUMBER), origin.y-(radius*i/RING_NUMBER), (radius*i/RING_NUMBER)*2, (radius*i/RING_NUMBER)*2));
	}
	CGContextSetLineWidth(context, 5);
	CGContextMoveToPoint(context, origin.x, origin.y-radius);
	CGContextAddLineToPoint(context, origin.x, origin.y);
	CGContextStrokePath(context);
	
	CGContextStrokeEllipseInRect(context, CGRectMake(origin.x-radius, origin.y-radius, radius*2, radius*2));
	
	NSArray* players = [[[JZPlayer sharedInstance] game] visablePlayers];
	for (int i = 0; i<[players count]; i++) {
		CGPoint* playerPoint = [self getRadarPointForPlayer:[players objectAtIndex:i]];
		
		playerPoint->x*=[self scalingFactor];
		playerPoint->y*=[self scalingFactor];
		CGFloat distance = sqrt(pow(playerPoint->x, 2)+pow(playerPoint->y, 2));
		if (distance>radius) {
			playerPoint->x = ((radius*playerPoint->x)/distance);
			playerPoint->y = ((radius*playerPoint->y)/distance);
		}
		
		playerPoint->x+=origin.x;
		playerPoint->y*=-1;
		playerPoint->y+=origin.y;
		
		
		CGContextSetFillColorWithColor(context, [[[[players objectAtIndex:i] team] teamColor] CGColor]);
		CGContextFillEllipseInRect(context, CGRectMake(playerPoint->x-playerDotRadius, playerPoint->y-playerDotRadius, playerDotRadius*2, playerDotRadius*2));
		
		free(playerPoint);
	}
	CGContextSetFillColorWithColor(context, [[[[JZPlayer sharedInstance] team] teamColor] CGColor]);
	CGContextFillEllipseInRect(context, CGRectMake(origin.x-playerDotRadius, origin.y-playerDotRadius, playerDotRadius*2, playerDotRadius*2));
}

-(CGPoint*)getRadarPointForPlayer:(JZGamePlayers *)player{
	
	CGPoint* point = malloc(sizeof(CGPoint));
	
	CLLocationCoordinate2D userLocation = [[[JZPlayer sharedInstance] gamePlayer] location].coordinate;
	
	CLLocationCoordinate2D playerLocation = [player location].coordinate;
	
	point->x = playerLocation.longitude-userLocation.longitude;
	point->y = playerLocation.latitude-userLocation.latitude;

	
	return point;
}

@end
