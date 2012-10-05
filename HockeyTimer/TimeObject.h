//
//  TimeObject.h
//  HockeyTimer
//
//  Created by George Uno on 10/5/12.
//  Copyright (c) 2012 Kuawa Road Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeObject : NSObject

@property (assign) int minutes;
@property (assign) int seconds;

-(NSString*)description;
+(id)initWithTimeInSeconds:(int)timeIn;

@end
