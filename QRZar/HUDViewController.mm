//
//  HUDViewController.m
//  QRZar
//
//  Created by Conor Brady on 04/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HUDViewController.h"
#import "JZPlayer.h"
#import "QRCodeReader.h"
#import "JZGlobalResources.h"

@interface HUDViewController (PrivateMethods) 

-(void) loopInitializer;
-(void) timerLoop;
-(void) setUpTopBar;
-(void) refreshDeadStatus;
-(void) handleKill:(NSNotification*)notification;
-(void) handleRespawn:(NSNotification*)notification;

@end

@implementation HUDViewController

@synthesize tabBar, topBar, rightTeamScore, rightTeamTitle, leftTeamScore, leftTeamTitle, clock, bloodSplatterOverlay, messageReadOut;
@synthesize widController = _widController;
@synthesize scanPending = _scanPending;
@synthesize loopTimer = _loopTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setWidController:[[ZXingWidgetController alloc] initWithDelegate:self showCancel:NO OneDMode:NO withCrop:CGRectMake(0, [topBar frame].size.height, 320, 480-[topBar frame].size.height-[tabBar frame].size.height)]];
		[[self view] setBackgroundColor:[UIColor clearColor]];
		[[self view] addSubview:[[self widController] view]];
		[[self view] sendSubviewToBack:[[self widController] view]];
		[self setUpTopBar];
		[self refreshDeadStatus];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpTopBar) name:@"Team Score Change" object:NULL];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDeadStatus) name:@"Alive Change" object:[JZPlayer sharedInstance]];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKill:) name:@"Kill Message" object:[[JZGlobalResources sharedInstance] topHatConnect]];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRespawn:) name:@"Respawn Message" object:[[JZGlobalResources sharedInstance] topHatConnect]];
		
		[NSThread detachNewThreadSelector:@selector(loopInitializer) toTarget:self withObject:nil];
		
    }
    return self;
}

-(void)loopInitializer{
	[self setLoopTimer:[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerLoop) userInfo:nil repeats:YES]];
	[[NSRunLoop currentRunLoop] run];
}

-(void)timerLoop{
	int secondsLeft = [[[[JZPlayer sharedInstance] game] endTime] timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970];
	[clock setText:[NSString stringWithFormat:@"%02i:%02i",secondsLeft/60,secondsLeft%60]];
	if (secondsLeft%2==0) {
		[NSThread detachNewThreadSelector:@selector(updateAlive) toTarget:[[JZGlobalResources sharedInstance] topHatConnect] withObject:NULL];
		[NSThread detachNewThreadSelector:@selector(updateTeamScores) toTarget:[[JZGlobalResources sharedInstance] topHatConnect] withObject:NULL];
		[NSThread detachNewThreadSelector:@selector(updateLocation) toTarget:[[JZGlobalResources sharedInstance] topHatConnect] withObject:NULL];
	}
}

- (void) setUpTopBar{
	[leftTeamScore setText:[NSString stringWithFormat:@"%i",[[[JZPlayer sharedInstance] team] teamScore]]];
	[leftTeamScore setBackgroundColor:[[[JZPlayer sharedInstance] team] teamColor]];
	[leftTeamTitle setBackgroundColor:[[[JZPlayer sharedInstance] team] teamColor]];
	JZTeam* secondTeam = [[[JZPlayer sharedInstance] game] getTeamAtRank:1];
	
	if (secondTeam != [[JZPlayer sharedInstance] team]) {
		[rightTeamScore setText:[NSString stringWithFormat:@"%i",[secondTeam teamScore]]];
		[rightTeamScore setBackgroundColor:[secondTeam teamColor]];
		[rightTeamTitle setText:@"1st Place"];
		[rightTeamTitle setBackgroundColor:[secondTeam teamColor]];
	}else{
		secondTeam = [[[JZPlayer sharedInstance] game] getTeamAtRank:2];
		[rightTeamScore setText:[NSString stringWithFormat:@"%i",[secondTeam teamScore]]];
		[rightTeamScore setBackgroundColor:[secondTeam teamColor]];
		[rightTeamTitle setText:@"2nd Place"];
		[rightTeamTitle setBackgroundColor:[secondTeam teamColor]];
	}
}

-(void)handleKill:(NSNotification*)notification{
	[self setScanPending:NO];
	if ([notification userInfo]==NULL) {
		[messageReadOut setText:@"Check Your Connection"];
	}else if(![[notification userInfo] objectForKey:@"error_code"]){
		[messageReadOut setText:@"Player Dead"];
	}else{
		switch ([[[notification userInfo] objectForKey:@"error_code"] intValue]) {
			case 404:
				[messageReadOut setText:@"That player is not playing"];
				break;
			case 409:
				[messageReadOut setText:@"That player is already dead."];
				break;
			default:
				[messageReadOut setText:@"For some reason you can't kill them."];
				break;
		}
	}
}

-(void)handleRespawn:(NSNotification*)notification{
	[self setScanPending:NO];
	if ([notification userInfo]==NULL) {
		[messageReadOut setText:@"Server problems."];
	}else{
		if ([[notification userInfo] valueForKey:@"error_code"]) {
			if ([[[notification userInfo] valueForKey:@"error_code"] intValue]==403) {
				[messageReadOut setText:@"Not a valid Respawn Code."];
			}else{
				[messageReadOut setText:@"A network error occured."];
			}
		}else{
			[messageReadOut setText:@"Welcome back."];
			[[JZPlayer sharedInstance] extendedSetAlive:YES];
		}
	}
}

-(void)refreshDeadStatus{
	[bloodSplatterOverlay setHidden:[[JZPlayer sharedInstance] alive]];
}

-(IBAction)startScan{
	if (![self scanPending]) {
		[messageReadOut setText:@""];
	}
	QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
	NSSet *readers = [[NSSet alloc] initWithObjects:qrcodeReader,nil];
	[self widController].readers = readers;
	
	if ([[JZPlayer sharedInstance] alive]) {
		
	}else{
		[bloodSplatterOverlay setImage:[UIImage imageNamed:@"BloodSplatterClearedAfterPress.png"]];
	}
}

-(IBAction)stopScan{
	
	[self widController].readers = NULL;
	
	if ([[JZPlayer sharedInstance] alive]) {
		
	}else{
		[bloodSplatterOverlay setImage:[UIImage imageNamed:@"BloodSplatter.png"]];
	}
}

-(void)zxingController:(ZXingWidgetController *)controller didScanResult:(JZQRInfo *)result{
	if ([[JZPlayer sharedInstance] alive]) {
		if (isupper([result.rawResult characterAtIndex:0])
			&& [result.rawResult characterAtIndex:0]!=[[[[JZPlayer sharedInstance] team] referenceCode] characterAtIndex:0]
			&& [result.rawResult length] == 6
			&& ![self scanPending]) {
				[self stopScan];
				[messageReadOut setText:@"Confirming Kill"];
				[self setScanPending:YES];
				[NSThread detachNewThreadSelector:@selector(playerHasKilledPlayerWithID:) toTarget:[[JZGlobalResources sharedInstance] topHatConnect] withObject:[result rawResult]];
		}
	}else{
		if ([result.rawResult length] == 6
			&& ![self scanPending]) {
				[self stopScan];
				[messageReadOut setText:@"Attempting Respawn"];
				[self setScanPending:YES];
				[NSThread detachNewThreadSelector:@selector(revivePlayer:) toTarget:[[JZGlobalResources sharedInstance] topHatConnect] withObject:[result rawResult]];
		}
	}
}

-(void)zxingControllerDidCancel:(ZXingWidgetController *)controller{
	
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[UIView animateWithDuration:0.3 animations:^(){
		[tabBar setFrame:CGRectMake(0, 480-[tabBar frame].size.height, 320, [tabBar frame].size.height)];
		[topBar setFrame:CGRectMake(0, 0, 320, [topBar frame].size.height)];
	}];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
