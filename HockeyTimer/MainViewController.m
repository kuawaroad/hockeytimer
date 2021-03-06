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
    int firstTriggerTime;
    int secondTriggerTime;
    AudioPlayer *firstBuzzer;
    AudioPlayer *secondBuzzer;
    NSTimer *timer;
    NSUserDefaults *defaults;
}

@end

@implementation MainViewController
@synthesize timeDisplay;
@synthesize repeatDisplay;
@synthesize firstBuzzerDisplay;
@synthesize secondBuzzerDisplay;
@synthesize refreshButton;
@synthesize infoButton;
@synthesize startButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    timerActive = NO;
    defaults = [NSUserDefaults standardUserDefaults];
    repetitionsLeft = [defaults integerForKey:@"Repeats"];
    firstTriggerTime = [defaults integerForKey:@"FirstBuzzer"];
    secondTriggerTime = [defaults integerForKey:@"SecondBuzzer"];
    
    [self customizeInterface];
    
    [self refreshInterface];
}

-(void)customizeInterface {
    self.timeDisplay.font = [UIFont fontWithName:@"Crystal" size:88.0];
    self.repeatDisplay.font = [UIFont fontWithName:@"Crystal" size:50.0];
    self.firstBuzzerDisplay.font = [UIFont fontWithName:@"Crystal" size:40.0];
    self.secondBuzzerDisplay.font = [UIFont fontWithName:@"Crystal" size:40.0];
    self.startButton.titleLabel.font = [UIFont fontWithName:@"Crystal" size:30.0];
    self.startButton.titleLabel.textColor = [UIColor blackColor];
    
    UIColor *textColor = [UIColor colorWithRed:159/255.0 green:229/255.0 blue:0/255.0 alpha:1.0];
    self.timeDisplay.textColor = textColor;
    self.repeatDisplay.textColor = textColor;
    self.firstBuzzerDisplay.textColor = textColor;
    self.secondBuzzerDisplay.textColor = textColor;
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
    [self setRefreshButton:nil];
    [self setStartButton:nil];
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

- (IBAction)refreshTapped:(id)sender {
    NSLog(@"Refresh Tapped");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reset Timer?" message:@"You're about to reset the timer, are you sure?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alertView show];
}

-(void)startTimer {
    NSLog(@"Starting Timer...");
    // schedule NSTimers
    timerActive = YES;
    [self.infoButton setEnabled:NO];
    [self.refreshButton setEnabled:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickTock) userInfo:nil repeats:YES];
}

-(void)stopTimer {
    NSLog(@"Stopping Timer.");
    [timer invalidate];
    timerActive = NO;
    //currentTime = 0;
    //repetitionsLeft = [defaults integerForKey:@"Repeats"];
    [self.infoButton setEnabled:YES];
    [self.refreshButton setEnabled:YES];
    [self refreshInterface];
}

-(void)tickTock {
    currentTime++;
    NSLog(@"Tick Tock %i",currentTime);
    [self checkForBuzzer];
    [self refreshInterface];
}

-(void)refreshInterface {
    
    self.timeDisplay.text = [self formatTime:currentTime];
    self.repeatDisplay.text = [NSString stringWithFormat:@"REPETITIONS: %i",repetitionsLeft];
    self.firstBuzzerDisplay.text = [NSString stringWithFormat:@"1ST: %@",[self formatTime:firstTriggerTime]];
    self.secondBuzzerDisplay.text = [NSString stringWithFormat:@"2ND: %@",[self formatTime:secondTriggerTime]];
}

-(void)resetTimer {
    NSLog(@"Resetting Timer");
    currentTime = 0;
    repetitionsLeft = [defaults integerForKey:@"Repeats"];
    [self refreshInterface];
}

-(void)restartTimer {
    NSLog(@"Restarting (LOOPING) Timer");
    currentTime = 0;
}

-(void)checkForBuzzer {
    // check current time against NSUserDefaults
    if (currentTime == firstTriggerTime) {
        [self playFirstBuzzer];
    } else if (currentTime == secondTriggerTime) {
        [self playSecondBuzzer];
    }
}

-(void)playFirstBuzzer {
    NSLog(@"Playing 1st Buzzer");
    firstBuzzer = [[AudioPlayer alloc] initWithSoundNamed:@"airhorn1x" ofType:@"mp3"];
    [firstBuzzer play];
}

-(void)playSecondBuzzer {
    NSLog(@"Playing 2nd Buzzer");
    secondBuzzer = [[AudioPlayer alloc] initWithSoundNamed:@"airhorn2x" ofType:@"mp3"];
    [secondBuzzer play];
    
    repetitionsLeft--;
    if (repetitionsLeft <= 0) {
        NSLog(@"Repetitions Over, Cancelling");
        [self stopTimer];
        [self resetTimer];
    } else {
        [self restartTimer];
    }
    [self refreshInterface];
}

-(void)refreshDefaults {
    currentTime = 0;
    repetitionsLeft = [defaults integerForKey:@"Repeats"];
    firstTriggerTime = [defaults integerForKey:@"FirstBuzzer"];
    secondTriggerTime = [defaults integerForKey:@"SecondBuzzer"];
    [self refreshInterface];
}

-(NSString *)formatTime:(int)timeInSeconds {
    int tempMins = timeInSeconds/60;
    int tempSecs = timeInSeconds % 60;
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
    return [NSString stringWithFormat:@"%@:%@",minutesString,secondsString];
}

#pragma mark UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Button Index = %i",buttonIndex);
    if (buttonIndex == 1) {
        // YES button tapped
        [self stopTimer];
        [self resetTimer];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation  == UIInterfaceOrientationPortrait);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self refreshDefaults];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [self resetTimer];
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
