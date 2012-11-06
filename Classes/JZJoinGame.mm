//
//  JZJoinGame.m
//  QRZar
//
//  Created by Conor Brady on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZJoinGame.h"
#import "QRCodeReader.h"
#import "HUDViewController.h"
#import "JZPlayer.h"

@interface JZJoinGame (PrivateMethods)

-(void)runGameStart;
-(void)connectAPI;

@end

@implementation JZJoinGame

@synthesize widController = _widController;
@synthesize gameCode = _gameCode;

// Synthesize IBOutlets
@synthesize gameReadLabel, gameScanButton, playerReadLabel,playerScanButton, joinGameView, cover, startSlider, joinGameButton, senderButton, feedbackLabel, indicator, contactingServer, networkErrorOKButton, networkRefreshButton, refreshState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setWidController:[[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withCrop:CGRectMake(0, 40, 320, 302)]];
        self.view.backgroundColor= [UIColor clearColor];
        [self.view addSubview:[self widController].view];
        [self.view sendSubviewToBack:[self widController].view];
		
    }
    return self;
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
	[playerScanButton setBackgroundImage:[[UIImage imageNamed:@"LaunchButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 60)] forState:UIControlStateNormal];
	[gameScanButton setBackgroundImage:[[UIImage imageNamed:@"LaunchButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 60)] forState:UIControlStateNormal];
	[joinGameButton setBackgroundImage:[[UIImage imageNamed:@"LaunchButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 60)] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[NSThread detachNewThreadSelector:@selector(connectAPI) toTarget:self withObject:NULL];
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

-(IBAction)slide{
	[UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
						 [startSlider setFrame:CGRectMake([startSlider frame].origin.x-320, [startSlider frame].origin.y, [startSlider frame].size.width, [startSlider frame].size.height)];
                     } 
                     completion:^(BOOL finished){}];
}

-(IBAction)startGame:(id)sender{
	
	[UIView animateWithDuration:0.3 animations:^(){
		[joinGameView setFrame:CGRectMake([joinGameView frame].origin.x, [startSlider frame].origin.y, [joinGameView frame].size.width, [joinGameView frame].size.height)];
		[cover setFrame:CGRectMake([cover frame].origin.x, [joinGameView frame].origin.y-[cover frame].size.height, [cover frame].size.width, [cover frame].size.height)];
		[startSlider setFrame:CGRectMake([startSlider frame].origin.x+320, [startSlider frame].origin.y, [startSlider frame].size.width, [startSlider frame].size.height)];
	}];
	[indicator setHidden:NO];
	[indicator startAnimating];
	[contactingServer setText:@"Contacting Server"];
	[contactingServer setHidden:NO];
	[networkErrorOKButton setHidden:YES];
	[NSThread detachNewThreadSelector:@selector(runGameStart) toTarget:self withObject:NULL];
}

-(void)connectAPI{
	
	[networkRefreshButton setHidden:YES];
	[indicator setHidden:NO];
	[indicator startAnimating];
	[contactingServer setText:@"Contacting Server"];
	[networkErrorOKButton setHidden:YES];
	
	if (([JZGlobalResources sharedInstance])!=NULL){
		[self slide];
	}else{
		[indicator setHidden:YES];
		[networkErrorOKButton setHidden:YES];
		[networkRefreshButton setHidden:NO];
		[contactingServer setHidden:NO];
		[contactingServer setText:@"Could Not Connect To Server"];
		refreshState = kConnect;
	}
}

-(IBAction)refreshNetwork{
	
	[indicator setHidden:NO];
	[indicator startAnimating];
	[contactingServer setText:@"Contacting Server"];
	[contactingServer setHidden:NO];
	[networkErrorOKButton setHidden:YES];
	[networkRefreshButton setHidden:YES];
	
	switch (refreshState) {
		case kJoin:
			[NSThread detachNewThreadSelector:@selector(runGameStart) toTarget:self withObject:NULL];
			break;
		case kConnect:
			[NSThread detachNewThreadSelector:@selector(connectAPI) toTarget:self withObject:NULL];
			break;
	}
}

-(void)runGameStart{
	
	int retCode = [[[JZGlobalResources sharedInstance] topHatConnect] joinGameWithID:[self gameCode]];
	
	switch (retCode) {
		case 200:
			[self presentModalViewController:[[HUDViewController alloc] init] animated:NO];
			break;
		case 0:
			[contactingServer setText:@"Empty Response from server"];
			[networkErrorOKButton setHidden:NO];
			[indicator setHidden:YES];
			[networkRefreshButton setHidden:YES];
			break;
		case -1:
			[contactingServer setText:@"Network Connection Failure"];
			refreshState = kJoin;
			[networkRefreshButton setHidden:NO];
			[indicator setHidden:YES];
			[networkErrorOKButton setHidden:YES];
			break;
		case 404:
			[contactingServer setText:@"Game not found"];
			[networkErrorOKButton setHidden:NO];
			[indicator setHidden:YES];
			[networkRefreshButton setHidden:YES];
			break;
		case 409:
			[contactingServer setText:@"Player already Exists"];
			[networkErrorOKButton setHidden:NO];
			[indicator setHidden:YES];
			[networkRefreshButton setHidden:YES];
			break;
		default:
			[contactingServer setText:[NSString stringWithFormat:@"Connection Error:%i",retCode]];
			[networkErrorOKButton setHidden:NO];
			[indicator setHidden:YES];
			[networkRefreshButton setHidden:YES];
			break;
	}
	
}

-(IBAction)startScan:(id)sender{
	
	senderButton = (ButtonTags)[sender tag];
	
	switch (senderButton) {
		case kJoinGame:
			
			break;
		case kScanGame:
			feedbackLabel.text = @"Scanning for Game ID.";
			break;
		case kScanPlayer:
			feedbackLabel.text = @"Scanning for Player ID.";
			break;
	}
	
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
						 [joinGameView setFrame:CGRectMake([joinGameView frame].origin.x, [startSlider frame].origin.y, [joinGameView frame].size.width, [joinGameView frame].size.height)];
						 [cover setFrame:CGRectMake([cover frame].origin.x, 0-[cover frame].size.height, [cover frame].size.width, [cover frame].size.height)];
                     } 
                     completion:^(BOOL finished){
						 QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
                         NSSet *readers = [[NSSet alloc] initWithObjects:qrcodeReader,nil];
                         [self widController].readers = readers;
					 }];

}

-(IBAction)stopScan:(id)sender{
    [self widController].readers = NULL;
	if (![playerReadLabel.text isEqualToString:@"Please Scan Player"]&&![gameReadLabel.text isEqualToString:@"Please Scan Game"]) {
		[UIView animateWithDuration:0.3
							  delay:0.0
							options: UIViewAnimationCurveEaseOut
						 animations:^{
							 [joinGameView setFrame:CGRectMake([joinGameView frame].origin.x, [startSlider frame].origin.y-[joinGameView frame].size.height-3, [joinGameView frame].size.width, [joinGameView frame].size.height)];
							 [cover setFrame:CGRectMake([cover frame].origin.x, [joinGameView frame].origin.y-[cover frame].size.height, [cover frame].size.width, [cover frame].size.height)];
						 } 
						 completion:^(BOOL finished){
							 [self widController].readers = nil;
						 }];
	}else{
		[UIView animateWithDuration:0.3
							  delay:0.0
							options: UIViewAnimationCurveEaseOut
						 animations:^{
							 [cover setFrame:CGRectMake([cover frame].origin.x, [joinGameView frame].origin.y-[cover frame].size.height, [cover frame].size.width, [cover frame].size.height)];
						 } 
						 completion:^(BOOL finished){
							 [self widController].readers = nil;
						 }];
	}
}

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(JZQRInfo *)result {
	switch (senderButton) {
		case kJoinGame:
			
			break;
		case kScanGame:
			if ([[result rawResult] intValue]) {
				[self setGameCode:result.rawResult];
				[gameReadLabel setText:[NSString stringWithFormat:@"Game ID:%@",result.rawResult]];
				[self stopScan:nil];
			}
			break;
		case kScanPlayer:
			if (isupper([result.rawResult characterAtIndex:0])&&[result.rawResult length]==6) {
				[[JZPlayer sharedInstance] setQrCode:result.rawResult];
				[playerReadLabel setText:[NSString stringWithFormat:@"Player ID:%@",result.rawResult]];
				[self stopScan:nil];
			}
			
			break;
	}
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller;{
    
}


@end
