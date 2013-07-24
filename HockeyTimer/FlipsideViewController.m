//
//  FlipsideViewController.m
//  HockeyTimer
//
//  Created by George Uno on 10/5/12.
//  Copyright (c) 2012 Kuawa Road Productions. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController () {
    // iVars
    NSUserDefaults *defaults;
}

@end

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize firstBuzzerTime = _firstBuzzerTime;
@synthesize secondBuzzerTime = _secondBuzzerTime;
@synthesize repeatTime = _repeatTime;
@synthesize firstLabel = _firstLabel;
@synthesize secondLabel = _secondLabel;
@synthesize repeatLabel = _repeatLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    defaults = [NSUserDefaults standardUserDefaults];
    self.firstBuzzerTime.text = [NSString stringWithFormat:@"%i",[defaults integerForKey:@"FirstBuzzer"]];
    self.secondBuzzerTime.text = [NSString stringWithFormat:@"%i",[defaults integerForKey:@"SecondBuzzer"]];
    self.repeatTime.text = [NSString stringWithFormat:@"%i",[defaults integerForKey:@"Repeats"]];
    
    self.firstLabel.font = [UIFont fontWithName:@"Crystal" size:36.0];
    self.secondLabel.font = [UIFont fontWithName:@"Crystal" size:36.0];
    self.repeatLabel.font = [UIFont fontWithName:@"Crystal" size:36.0];
    self.firstBuzzerTime.font = [UIFont fontWithName:@"Crystal" size:18.0];
    self.secondBuzzerTime.font = [UIFont fontWithName:@"Crystal" size:18.0];
    self.repeatTime.font = [UIFont fontWithName:@"Crystal" size:18.0];
    
    UIColor *textColor = [UIColor colorWithRed:159/255.0 green:229/255.0 blue:0/255.0 alpha:1.0];
    self.firstLabel.textColor = textColor;
    self.secondLabel.textColor = textColor;
    self.repeatLabel.textColor = textColor;
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}

- (void)viewDidUnload
{
    [self setFirstBuzzerTime:nil];
    [self setSecondBuzzerTime:nil];
    [self setRepeatTime:nil];
    [self setFirstLabel:nil];
    [self setSecondLabel:nil];
    [self setRepeatLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    if ([self emptyFieldExists]) {
        // there's an empty field...
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"EMPTY FIELD!" message:@"You must enter a value in each of the three fields and the 1st & 2nd buzzer times must be more than 0.  The 2nd buzzer time must also be AFTER the 1st buzzer time." delegate:self cancelButtonTitle:@"SORRY I'M DUMB" otherButtonTitles:nil];
        [alertView show];
    } else {
        // fields all have a value
        NSLog(@"Flipside DONE: Setting UserDefaults");
        [defaults setInteger:[self.firstBuzzerTime.text intValue] forKey:@"FirstBuzzer"];
        [defaults setInteger:[self.secondBuzzerTime.text intValue] forKey:@"SecondBuzzer"];
        [defaults setInteger:[self.repeatTime.text intValue] forKey:@"Repeats"];
        [defaults synchronize];
        
        [self.delegate flipsideViewControllerDidFinish:self];
    }
}

-(BOOL)emptyFieldExists {
    
    if ([self.firstBuzzerTime.text length] < 1) {
        return YES;
    } else if ([self.firstBuzzerTime.text length] < 1) {
        return YES;
    } else if ([self.firstBuzzerTime.text length] < 1)  {
        return YES;
    } else if ([self.repeatTime.text length] < 1)  {
        return YES;
    } else if ([self.firstBuzzerTime.text intValue] < 1)  {
        return YES;
    } else if ([self.secondBuzzerTime.text intValue] < 1)  {
        return YES;
    } else if ([self.firstBuzzerTime.text intValue] >= [self.secondBuzzerTime.text intValue])  {
        return YES;
    } else {
        return NO;
    }
}

@end
