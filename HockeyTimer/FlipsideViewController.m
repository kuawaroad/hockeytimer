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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    defaults = [NSUserDefaults standardUserDefaults];
    self.firstBuzzerTime.text = [NSString stringWithFormat:@"%i",[defaults integerForKey:@"FirstBuzzer"]];
    self.secondBuzzerTime.text = [NSString stringWithFormat:@"%i",[defaults integerForKey:@"SecondBuzzer"]];
    self.repeatTime.text = [NSString stringWithFormat:@"%i",[defaults integerForKey:@"Repeats"]];
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
    NSLog(@"Flipside DONE: Setting UserDefaults");
    [defaults setInteger:[self.firstBuzzerTime.text intValue] forKey:@"FirstBuzzer"];
    [defaults setInteger:[self.secondBuzzerTime.text intValue] forKey:@"SecondBuzzer"];
    [defaults setInteger:[self.repeatTime.text intValue] forKey:@"Repeats"];
    [defaults synchronize];
    
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
