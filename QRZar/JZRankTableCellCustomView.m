//
//  JZRankTableCellCustomView.m
//  QRZar
//
//  Created by Conor Brady on 07/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZRankTableCellCustomView.h"

@implementation JZRankTableCellCustomView

@synthesize player = _player;
@synthesize row = _row;

- (id)initWithFrame:(CGRect)frame andPlayer:(JZGamePlayers *)player rowNumber:(int)row;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlayer:player];
		[self setRow:row+1];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [[[[self player] team] teamColor] CGColor]);
	CGContextFillRect(context, rect);
	UIImage* skin = [UIImage imageNamed:@"LaunchBrightBackground"];
	[skin drawInRect:rect blendMode:kCGBlendModeSaturation alpha:1.0];
	UIImage* img = [[UIImage imageNamed:@"RanksTableFrame"] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 75)];
	[img drawInRect:rect];
	
	
	CGContextSetFillColorWithColor(context, [[UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchBrightBackground"]] CGColor]);

	[[NSString stringWithFormat:@"%i",[self row]] drawInRect:CGRectMake(20, rect.size.height/3,40,rect.size.height/3) withFont:[UIFont fontWithName:@"GillSans-Bold" size:rect.size.height/3] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
	
	[[[[[self player] name] componentsSeparatedByString:@" "] objectAtIndex:0] drawInRect:CGRectMake(70, rect.size.height/3,160,rect.size.height/3) withFont:[UIFont fontWithName:@"GillSans-Bold" size:rect.size.height/3] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentLeft];
	
	[[NSString stringWithFormat:@"%i",[[self player] score]] drawInRect:CGRectMake(230, rect.size.height/3,60,rect.size.height/3) withFont:[UIFont fontWithName:@"GillSans-Bold" size:rect.size.height/3] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentRight];
	
	
}


@end
