//
//  TimeObject.m
//  HockeyTimer
//
//  Created by George Uno on 10/5/12.
//  Copyright (c) 2012 Kuawa Road Productions. All rights reserved.
//

#import "TimeObject.h"

@implementation TimeObject

@synthesize minutes, seconds;

+(id)initWithTimeInSeconds:(int)timeIn {
    if ([super init]) {
        
        // initialize
    int tempMins = timeIn/60;
    int tempSecs = timeIn % 60;
    NSLog(@"TimeIn:%i Mins:%i Secs:%i",timeIn,tempMins,tempSecs);
    
    }
    
    return self;
}

-(NSString*)description {
    NSString *minutesString;
    if (self.minutes < 10) {
        minutesString = [NSString stringWithFormat:@"0%i",self.minutes];
    } else {
        minutesString = [NSString stringWithFormat:@"%i",self.minutes];
    }
    
    
    NSString *secondsString;
    if (self.seconds < 10) {
        secondsString = [NSString stringWithFormat:@"0%i",self.seconds];
    } else {
        secondsString = [NSString stringWithFormat:@"%i",self.seconds];
    }
    
    NSString *returnString = [NSString stringWithFormat:@"%@:%@",minutesString,secondsString];
    
    return returnString;
}

-(void) dealloc {
    
}

@end
