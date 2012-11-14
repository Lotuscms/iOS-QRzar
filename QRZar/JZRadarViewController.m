//
//  JZRadarViewController.m
//  QRZar
//
//  Created by Conor Brady on 08/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZRadarViewController.h"
#import "JZRadarView.h"
#import "JZGlobalResources.h"

@interface JZRadarViewController (PrivateMethods)

-(void)dismiss;
-(void)redrawLoop;

@end

@implementation JZRadarViewController


@synthesize loopTimer = _loopTimer;
@synthesize radarView, zoomIn, zoomOut, feedbackLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self setTitle:@"Radar"];
		UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
		self.navigationItem.rightBarButtonItem = done;
		[[self view] setBackgroundColor:[UIColor blackColor]];
		
		if ((int)(15540000/[radarView scalingFactor])>1000) {
			[feedbackLabel setText:[NSString stringWithFormat:@"Radius : %d km",(int)(15540000/[radarView scalingFactor]/1000)]];
		}else{
			[feedbackLabel setText:[NSString stringWithFormat:@"Radius : %d m",(int)(15540000/[radarView scalingFactor])]];
		}
		[zoomIn setBackgroundImage:[[UIImage imageNamed:@"LaunchButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 60)] forState:UIControlStateNormal];
		[zoomOut setBackgroundImage:[[UIImage imageNamed:@"LaunchButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 60)] forState:UIControlStateNormal];
		[NSThread detachNewThreadSelector:@selector(redrawLoop) toTarget:self withObject:nil];
    }
    return self;
}

-(IBAction)zoom:(id)sender{
	if ([sender tag]==1) {
		[radarView setScalingFactor:[radarView scalingFactor]*2];
	}else{
		[radarView setScalingFactor:[radarView scalingFactor]/2];
	}
	[zoomOut setEnabled:[radarView scalingFactor]>8000];
	[zoomIn setEnabled:[radarView scalingFactor]<512000];
	if ((int)(15540000/[radarView scalingFactor])>1000) {
		[feedbackLabel setText:[NSString stringWithFormat:@"Radius : %d km",(int)(15540000/[radarView scalingFactor]/1000)]];
	}else{
		[feedbackLabel setText:[NSString stringWithFormat:@"Radius : %d m",(int)(15540000/[radarView scalingFactor])]];
	}
	[radarView setNeedsDisplay];
	
}

-(void)headingUpdate:(CLHeading *)heading{
	float headingf = heading.magneticHeading; //in degrees
	float headingDegrees = (headingf*M_PI/180); //assuming needle points to top of iphone. convert to radians
	[radarView setTransform:CGAffineTransformMakeRotation(-headingDegrees)];
	
}


-(void)redrawLoop{
	[self setLoopTimer:[NSTimer scheduledTimerWithTimeInterval:2 target:radarView selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES]];
	[[NSRunLoop currentRunLoop] run];
}

-(void)dismiss{
	[self dismissModalViewControllerAnimated:YES];
	[[self loopTimer] invalidate];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[[JZGlobalResources sharedInstance] locationManager] setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	[[[JZGlobalResources sharedInstance] locationManager] setDelegate:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
