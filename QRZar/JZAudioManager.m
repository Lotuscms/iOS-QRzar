//
//  JZAudioManager.m
//  QRZar
//
//  Created by Conor Brady on 09/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JZAudioManager.h"

static JZAudioManager* singleton = nil;

@implementation JZAudioManager

@synthesize doorSoundPlayer = _doorSoundPlayer;
@synthesize launchMusicPlayer = _launchMusicPlayer;
@synthesize scannerSoundPlayer = _scannerSoundPlayer;

+(JZAudioManager*)sharedInstance{
	if (singleton==nil) {
		singleton = [[JZAudioManager alloc] init];
		
		UInt32 otherAudioIsPlaying;                                   
		UInt32 propertySize = sizeof (otherAudioIsPlaying);
		
		AudioSessionGetProperty (                                     
								 kAudioSessionProperty_OtherAudioIsPlaying,
								 &propertySize,
								 &otherAudioIsPlaying
								 );
		
		if (otherAudioIsPlaying) {                                    
			[[AVAudioSession sharedInstance]
			 setCategory: AVAudioSessionCategoryAmbient
			 error: nil];
		} else {
			[[AVAudioSession sharedInstance]
			 setCategory: AVAudioSessionCategorySoloAmbient
			 error: nil];
		}
		[[AVAudioSession sharedInstance] setActive:YES error:nil];
		
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DST-DarkFuture" ofType:@"mp3"];
		[singleton setLaunchMusicPlayer:[[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:filePath] error:nil]];
		[singleton.launchMusicPlayer setNumberOfLoops:-1];
		
		NSString* scannerSoundFile = [[NSBundle mainBundle] pathForResource:@"scanner" ofType:@"mp3"];
		[singleton setScannerSoundPlayer:[[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:scannerSoundFile] error:nil]];
		[[singleton scannerSoundPlayer] setNumberOfLoops:-1];
		[[singleton scannerSoundPlayer] setVolume:0.3];
		
		
		
	}
	
	return singleton;
}

-(void)playLaunchMusic:(BOOL)play{
	if (play) {
		[[self launchMusicPlayer] play];
	}else{
		[[self launchMusicPlayer] pause];
	}
}

-(void)playScannerEffect:(BOOL)play{
	if (play) {
		[[self scannerSoundPlayer] play];
	}else{
		[[self scannerSoundPlayer] pause];
	}
}

-(void)fireDoorSound{
	NSString* soundEffectFile = [[NSBundle mainBundle] pathForResource:@"electric_door_opening_2" ofType:@"wav"];
	[self setDoorSoundPlayer:[[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:soundEffectFile] error:nil]];
	[[self doorSoundPlayer] play];
}



@end
