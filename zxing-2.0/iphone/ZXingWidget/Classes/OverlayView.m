/**
 * Copyright 2009 Jeff Verkoeyen
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "OverlayView.h"

static const CGFloat kPadding = 10;

@interface OverlayView()
@end


@implementation OverlayView

@synthesize delegate, oneDMode;
@synthesize points = _points;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled {
  self = [super initWithFrame:theFrame];
  if( self ) {

    

    self.backgroundColor = [UIColor clearColor];
    self.oneDMode = isOneDModeEnabled;
    if (isCancelEnabled) {
     
      [self addSubview:imageView];
    }
  }
  return self;
}



////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	[imageView release];
	[_points release];
  [instructionsLabel release];
	[super dealloc];
}


- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context {
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
	CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
	CGContextStrokePath(context);
}

- (CGPoint)map:(CGPoint)point {
    CGPoint center;
    float x = point.x - center.x;
    float y = point.y - center.y;
    int rotation = 90;
    switch(rotation) {
    case 0:
        point.x = x;
        point.y = y;
        break;
    case 90:
        point.x = -y;
        point.y = x;
        break;
    case 180:
        point.x = -x;
        point.y = -y;
        break;
    case 270:
        point.x = y;
        point.y = -x;
        break;
    }
    point.x = point.x + center.x;
    point.y = point.y + center.y;
    return point;
}

#define kTextMargin 10

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	CGContextRef c = UIGraphicsGetCurrentContext();
  
	if (nil != _points) {
    //		[imageView.image drawAtPoint:cropRect.origin];
	}
	
	CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f};
	CGContextSetStrokeColor(c, white);
	CGContextSetFillColor(c, white);
	
  //	CGContextSetStrokeColor(c, white);
	//	CGContextSetStrokeColor(c, white);
	CGContextSaveGState(c);
	
	CGContextRestoreGState(c);
	int offset = rect.size.width / 2;
	if (oneDMode) {
		CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
		CGContextSetStrokeColor(c, red);
		CGContextSetFillColor(c, red);
		CGContextBeginPath(c);
		//		CGContextMoveToPoint(c, rect.origin.x + kPadding, rect.origin.y + offset);
		//		CGContextAddLineToPoint(c, rect.origin.x + rect.size.width - kPadding, rect.origin.y + offset);
		CGContextMoveToPoint(c, rect.origin.x + offset, rect.origin.y + kPadding);
		CGContextAddLineToPoint(c, rect.origin.x + offset, rect.origin.y + rect.size.height - kPadding);
		CGContextStrokePath(c);
	}
	if( nil != _points ) {
		CGFloat blue[4] = {0.0f, 1.0f, 0.0f, 1.0f};
		CGContextSetStrokeColor(c, blue);
		CGContextSetFillColor(c, blue);
		if (oneDMode) {
			CGPoint val1 = [self map:[[_points objectAtIndex:0] CGPointValue]];
			CGPoint val2 = [self map:[[_points objectAtIndex:1] CGPointValue]];
			CGContextMoveToPoint(c, offset, val1.x);
			CGContextAddLineToPoint(c, offset, val2.x);
			CGContextStrokePath(c);
		}
		else {
			CGRect smallSquare = CGRectMake(0, 0, 10, 10);
			for( NSValue* value in _points ) {
				[self drawRect:smallSquare inContext:c];
			}
		}
	}
}


////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 - (void) setImage:(UIImage*)image {
 //if( nil == imageView ) {
// imageView = [[UIImageView alloc] initWithImage:image];
// imageView.alpha = 0.5;
// } else {
 imageView.image = image;
 //}
 
 //CGRect frame = imageView.frame;
 //frame.origin.x = self.cropRect.origin.x;
 //frame.origin.y = self.cropRect.origin.y;
 //imageView.frame = CGRectMake(0,0, 30, 50);
 
 //[_points release];
 //_points = nil;
 //self.backgroundColor = [UIColor clearColor];
 
 //[self setNeedsDisplay];
 }
 */

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*) image {
	return imageView.image;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setPoints:(NSMutableArray*)pnts {
    [pnts retain];
    [_points release];
    _points = pnts;
	
    if (pnts != nil) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    }
    [self setNeedsDisplay];
}

- (void) setPoint:(CGPoint)point {
    if (!_points) {
        _points = [[NSMutableArray alloc] init];
    }
    if (_points.count > 3) {
        [_points removeObjectAtIndex:0];
    }
    [_points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}


@end
