//
//  JZHUD.m
//  QRZar
//
//  Created by Conor Brady on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZHUD.h"

@implementation JZHUD

@synthesize widController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withCrop:CGRectMake(20, 30, 30, 30)];
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

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result{
    
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller{
    
}

- (IBAction)scanButtonWasPressed{
    [widController setTorch:YES];
}

- (IBAction)scanButtonWasReleased{
    [widController setTorch:NO];
}

@end
