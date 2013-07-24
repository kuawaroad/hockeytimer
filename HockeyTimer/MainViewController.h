//
//  MainViewController.h
//  HockeyTimer
//
//  Created by George Uno on 10/5/12.
//  Copyright (c) 2012 Kuawa Road Productions. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *timeDisplay;
@property (strong, nonatomic) IBOutlet UILabel *repeatDisplay;
@property (strong, nonatomic) IBOutlet UILabel *firstBuzzerDisplay;
@property (strong, nonatomic) IBOutlet UILabel *secondBuzzerDisplay;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startButtonTapped:(id)sender;
- (IBAction)refreshTapped:(id)sender;

@end
