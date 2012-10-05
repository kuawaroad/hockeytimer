//
//  AudioPlayer.h
//  HockeyTimer
//
//  Created by George Uno on 10/5/12.
//  Copyright (c) 2012 Kuawa Road Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

@interface AudioPlayer : NSObject 
{
    SystemSoundID soundID;
}

-(id)initWithSoundNamed:(NSString *)filename ofType:(NSString*)extension;
-(void)play;

@end
