//
//  MainViewController.m
//  HockeyTimer
//
//  Created by George Uno on 10/5/12.
//  Copyright (c) 2012 Kuawa Road Productions. All rights reserved.
//

#import "MainViewController.h"
#import "AudioPlayer.h"

@interface MainViewController () {
    // iVARS
    BOOL timerActive;
    int currentTime;
    int repetitionsLeft;
    AudioPlayer *firstBuzzer;
    AudioPlayer *secondBuzzer;
    NSTimer *timer;
}

@end

@implementation MainViewController
@synthesize timeDisplay;
@synthesize repeatDisplay;
@synthesize firstBuzzerDisplay;
@synthesize secondBuzzerDisplay;
@synthesize infoButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    timerActive = NO;
}



- (void)viewDidUnload
{
    [self setTimeDisplay:nil];
    [self setRepeatDisplay:nil];
    [self setFirstBuzzerDisplay:nil];
    [self setSecondBuzzerDisplay:nil];
    [self setInfoButton:nil];
    firstBuzzer = nil;
    secondBuzzer = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)startButtonTapped:(id)sender {
    // if not active, start, if active stop & reset
    if (timerActive) {
        // timer already active
        [self stopTimer];
    } else {
        // timer not active
        [self startTimer];
    }
}

-(void)startTimer {
    NSLog(@"Starting Timer...");
    // schedule NSTimers
    timerActive = YES;
    [self.infoButton setEnabled:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickTock) userInfo:nil repeats:YES];
}

-(void)stopTimer {
    NSLog(@"Stopping Timer.");
    [timer invalidate];
    [self.infoButton setEnabled:YES];
}

-(void)tickTock {
    NSLog(@"Tick Tock %f",timer.timeInterval);
    currentTime++;
    [self checkForBuzzer];
    [self refreshInterface];
}

-(void)refreshInterface {
    int tempMins = currentTime/60;
    int tempSecs = currentTime % 60;
    NSString *minutesString;
    if (tempMins < 10) {
        minutesString = [NSString stringWithFormat:@"0%i",tempMins];
    } else {
        minutesString = [NSString stringWithFormat:@"%i",tempMins];
    }
    
    NSString *secondsString;
    if (tempSecs < 10) {
        secondsString = [NSString stringWithFormat:@"0%i",tempSecs];
    } else {
        secondsString = [NSString stringWithFormat:@"%i",tempSecs];
    }
    
    NSString *timeString = [NSString stringWithFormat:@"%@:%@",minutesString,secondsString];
    self.timeDisplay.text = timeString;
    
    self.repeatDisplay.text = [NSString stringWithFormat:@""];
    
}

-(void)resetTimer {
    NSLog(@"Resetting Timer");
    currentTime = 0;
    
    if (repetitionsLeft > 0) {
        [self startTimer];
    } else {
        [self stopTimer];
    }
}

-(void)checkForBuzzer {
    // check current time against NSUserDefaults
}

-(void)playFirstBuzzer {
    NSLog(@"Playing 1st Buzzer");
    firstBuzzer = [[AudioPlayer alloc] initWithSoundNamed:@"power_down" ofType:@"mp3"];
    [firstBuzzer play];
}

-(void)playSecondBuzzer {
    NSLog(@"Playing 2nd Buzzer");
    secondBuzzer = [[AudioPlayer alloc] initWithSoundNamed:@"explosion" ofType:@"mp3"];
    [secondBuzzer play];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation  == UIInterfaceOrientationPortrait);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
