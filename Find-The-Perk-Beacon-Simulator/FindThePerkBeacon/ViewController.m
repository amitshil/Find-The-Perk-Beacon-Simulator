//
//  ViewController.m
//  FindThePerkBeacon
//
//  Created by Amit Shil on 17/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *startDemoButton;
@property (nonatomic, weak) IBOutlet UIButton *allEventsButton;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    _startDemoButton.layer.cornerRadius = 6.0f;
    _allEventsButton.layer.cornerRadius = 6.0f;
}

@end
