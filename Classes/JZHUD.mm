//
//  JZHUD.m
//  QRZar
//
//  Created by Conor Brady on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZHUD.h"
#import "QRCodeReader.h"

const int SERVER_PING_DELAY = 5;

@implementation JZHUD

@synthesize widController, badge, time, timer, redTeamScore, blueTeamScore, powerUpPanel, bg, bonus, movingBG, cogs, trim, team, gameID, playerID, resources;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withCrop:CGRectMake(50, 30, 270, 270)];
        self.view.backgroundColor= [UIColor clearColor];
        [self.view addSubview:widController.view];
        [self.view sendSubviewToBack:widController.view];
    }
    return self;
}

-(void)passJoinScan:(JZQRInfo*)i withResource:(JZGlobalResources *)r{
	
	resources = r;
	
	[self setGameID:i.gameID];
	[self setPlayerID:i.playerID];
	[self setTeam:i.team];
	switch (team) {
		case 'B':
			[self.badge setImage:[UIImage imageNamed:@"blueteamBadge.png"]];
			break;
			
		case 'R':
			[self.badge setImage:[UIImage imageNamed:@"RedTeamBadge.png"]];
			break;
			
		default:
			break;
	}
		
	
	//post player to the server
	//create game if it is not currently active
	
	//get game info from server
	//for now ill put in a value
	
	time = 1000;
	[self countdown];
	[redTeamScore setText:@"0"];
	[blueTeamScore setText:@"0"];
	
}






-(void)countdown{
	
	[timer setText: --time%60>9 ? [NSString stringWithFormat:@"%i:%i",time/60,time%60] : [NSString stringWithFormat:@"%i:0%i",time/60,time%60]];
	if (time == 0) {
		[self endGame];
		return;
	}
	[self performSelector:@selector(countdown) withObject:NULL afterDelay:1];
	
}


-(void)serverPing{
	
	[self performSelector:@selector(serverPing) withObject:NULL afterDelay:SERVER_PING_DELAY];
	
}




-(void)endGame{
	// end game code goes here
	[self dismissModalViewControllerAnimated:NO];
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



// ZXing Delegate Methods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(JZQRInfo *)result{
	if (result!=NULL && [[result gameID] isEqualToString:[self gameID]] && resources.blocker.check) {
		NSLog(@"%@",[result playerID]);
		
	}
    
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller{
    
}



// scan button methods

- (IBAction)scanButtonWasPressed{
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
    widController.readers = readers;
	[bg setImage:[UIImage imageNamed:@"onfire.png"]];
}

- (IBAction)scanButtonWasReleased{
    widController.readers = NULL;
	[bg setImage:[UIImage imageNamed:@"hudbg.png"]];
}



// power up animation

-(IBAction)showPowerUpPanel{
	[UIView animateWithDuration:.7 animations:^{
		bonus       .frame = CGRectMake(0,   80, 320, 125); 
		movingBG    .frame = CGRectMake(0,    0, 320, 320); 
		cogs        .frame = CGRectMake(0,    0, 320, 168);
		powerUpPanel.frame = CGRectMake(0,  286, 320, 194);
		trim		.frame = CGRectMake(0,  128, 320,  54);
	}];
}

-(IBAction)dismissPowerUpPanel{
	[UIView animateWithDuration:.7 animations:^{
		bonus		.frame = CGRectMake(0, -400, 320, 125); 
		movingBG	.frame = CGRectMake(0, -210, 320, 320); 
		cogs		.frame = CGRectMake(0, -350, 320, 168);
		powerUpPanel.frame = CGRectMake(0,  480, 320, 194);
		trim		.frame = CGRectMake(0,  -65, 320,  54);
	}];
	
}

@end
