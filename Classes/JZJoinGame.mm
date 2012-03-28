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
@synthesize btm, lft, rht;
@synthesize widController, resources;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withCrop:CGRectMake(10, 30, 270, 270)];
        self.view.backgroundColor= [UIColor clearColor];
        [self.view addSubview:widController.view];
        [self.view sendSubviewToBack:widController.view];
        resources = [[JZGlobalResources alloc] init];
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
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         top.frame = CGRectMake(0, -153, 320, 153);
                         btm.frame = CGRectMake(0, 305, 320, 154);
                     } 
                     completion:^(BOOL finished){}];
	
    [UIView animateWithDuration:0.3
                          delay:0.3
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         lft.frame = CGRectMake(-160, 0, 160, 308);
                         rht.frame = CGRectMake(320, 0, 160, 308);
                     } 
                     completion:^(BOOL finished){
                         QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
                         NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
                         widController.readers = readers;
                     }];
    
    
}

-(IBAction)closeSliders{
    widController.readers = NULL;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         top.frame = CGRectMake(0, 0, 320, 153);
                         btm.frame = CGRectMake(0, 151, 320, 154);
                         lft.frame = CGRectMake(0, 0, 160, 308);
                         rht.frame = CGRectMake(160, 0, 160, 308);
                     } 
                     completion:^(BOOL finished){
                     }];
    
}

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(JZQRInfo *)result {
    
    if(result!=NULL && resources.blocker.check){ 
        resources.topHatConnect = [[JZTopHatConnect alloc] initWithPlayerID:[result playerID]];
        if (resources.topHatConnect!=nil) {
            JZHUD* hud = [[JZHUD alloc] init];
            [self presentModalViewController:hud animated:NO];
            self.widController = NULL;
            [hud passJoinScan:result withResource:resources];
        }     
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
