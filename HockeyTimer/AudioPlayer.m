//
//  AudioPlayer.m
//  HockeyTimer
//
//  Created by George Uno on 10/5/12.
//  Copyright (c) 2012 Kuawa Road Productions. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer

-(id)initWithSoundNamed:(NSString *)filename ofType:(NSString *)extension
{
    if ((self = [super init])) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:extension];
        if (fileURL != nil) {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError) {
                soundID = theSoundID;
            }
        }
    }
    return self;
}

-(void)play
{
    AudioServicesPlaySystemSound(soundID);
    NSLog(@"Playing Sound... %lu",soundID);
}

-(void) dealloc
{
    NSLog(@"Disposing of SoundID");
    AudioServicesDisposeSystemSoundID(soundID);
}

@end
