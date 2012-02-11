//
//  JZJoinGame.m
//  QRZar
//
//  Created by Conor Brady on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZJoinGame.h"
#import "QRCodeReader.h"
#import "JZInfoScreen.h"
#import "JZRank.h"
#import "JZHUD.h"

@implementation JZJoinGame

@synthesize top;
@synthesize btm;
@synthesize widController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withCrop:CGRectMake(50, 70, 250, 250)];
        self.view.backgroundColor= [UIColor clearColor];
        [self.view addSubview:widController.view];
        [self.view sendSubviewToBack:widController.view];
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

-(IBAction)openSliders{
    [top setHidden:TRUE];
    [btm setHidden:TRUE];
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
    widController.readers = readers;
    [widController setTorch:YES];
}

-(IBAction)closeSliders{
    [top setHidden:false];
    [btm setHidden:false];
    widController.readers = NULL;
    [widController setTorch:NO];
}

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    NSLog(@"%@",result);
    bool validResult = true;
    // Needs to be validated here
    
    if(validResult){
        // progress to game
        [self presentModalViewController:[[JZHUD alloc] init] animated:NO];
        [widController setTorch:NO];
        self.widController = NULL;
        
        
    }else{
        // reset scanner for a valid code
    }
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller;{
    
}

-(IBAction)info{
    [self presentModalViewController:[[JZInfoScreen alloc] init] animated:YES];
}

-(IBAction)rank{
    [self presentModalViewController:[[JZRank alloc] init] animated:YES];
}

@end
