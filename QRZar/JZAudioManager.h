//
//  JZAudioManager.h
//  QRZar
//
//  Created by Conor Brady on 09/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface JZAudioManager : NSObject{
	AVAudioPlayer* _launchMusicPlayer;
	AVAudioPlayer* _doorSoundPlayer;
	AVAudioPlayer* _scannerSoundPlayer;
}

@property (nonatomic, retain) AVAudioPlayer* launchMusicPlayer;
@property (nonatomic, retain) AVAudioPlayer* doorSoundPlayer;
@property (nonatomic, retain) AVAudioPlayer* scannerSoundPlayer;

+(JZAudioManager*)sharedInstance;

-(void)playLaunchMusic:(BOOL)play;

-(void)playScannerEffect:(BOOL)play;

-(void)fireDoorSound;

@end
