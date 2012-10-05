//
//  FlipsideViewController.h
//  HockeyTimer
//
//  Created by George Uno on 10/5/12.
//  Copyright (c) 2012 Kuawa Road Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *firstBuzzerTime;
@property (strong, nonatomic) IBOutlet UITextField *secondBuzzerTime;
@property (strong, nonatomic) IBOutlet UITextField *repeatTime;

- (IBAction)done:(id)sender;

@end
