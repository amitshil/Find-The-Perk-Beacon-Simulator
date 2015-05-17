//
//  EventsViewController.m
//  FindThePerkBeacon
//
//  Created by Amit Shil on 17/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import "EventsViewController.h"
#import "Beacon.h"
#import "Constants.h"

@interface EventsViewController ()
{
    NSArray *beacons;
    NSUInteger index;
}

@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) NSDictionary *myBeaconData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end

@implementation EventsViewController

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
    
    for(id v in self.view.subviews)
    {
        if([v isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton*)v;
            [button setBackgroundColor:[UIColor colorWithRed:91.0f/255.0f green:114.0f/255.0f blue:143.0f/255.0f alpha:1.0f]];
            button.layer.cornerRadius = 6.0f;
        }
    }
    _closeButton.backgroundColor = [UIColor clearColor];
    
    index = 0;
    [self initBeacons];
}

-(void)initBeacons
{
    NSMutableArray *beaconsArray = [[NSMutableArray alloc] init];
    Beacon *beacon = [[Beacon alloc] init];
    beacon.major = [NSNumber numberWithInt:Major_Clue1];
    beacon.minor = [NSNumber numberWithInt:Minor_Clue1];
    [beaconsArray addObject:beacon];
    
    beacon = [[Beacon alloc] init];
    beacon.major = [NSNumber numberWithInt:Major_Clue2];
    beacon.minor = [NSNumber numberWithInt:Minor_Clue2];
    [beaconsArray addObject:beacon];
    
    beacon = [[Beacon alloc] init];
    beacon.major = [NSNumber numberWithInt:Major_Clue3];
    beacon.minor = [NSNumber numberWithInt:Minor_Clue3];
    [beaconsArray addObject:beacon];
    
    beacon = [[Beacon alloc] init];
    beacon.major = [NSNumber numberWithInt:Major_Clue4];
    beacon.minor = [NSNumber numberWithInt:Minor_Clue4];
    [beaconsArray addObject:beacon];
    
    beacon = [[Beacon alloc] init];
    [beaconsArray addObject:beacon];
    
    beacons = beaconsArray;
}

- (IBAction)action:(id)sender
{
    for(id v in self.view.subviews)
    {
        if([v isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton*)v;
            [button setBackgroundColor:[UIColor colorWithRed:91.0f/255.0f green:114.0f/255.0f blue:143.0f/255.0f alpha:1.0f]];
        }
    }
    
    _closeButton.backgroundColor = [UIColor clearColor];
    
    UIButton *button = (UIButton*)sender;
    [button setBackgroundColor:[UIColor colorWithRed:61/255.0f green:150/255.0f blue:213/255.0f alpha:1.0f]];
    
    if(self.peripheralManager.isAdvertising)
    {
        [self.peripheralManager stopAdvertising];
        self.peripheralManager = nil;
        self.myBeaconData = nil;
        self.myBeaconRegion = nil;
    }
    
    Beacon *beacon = [beacons objectAtIndex:button.tag];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:Demo_UUID];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                  major:[beacon.major intValue]
                                                                  minor:[beacon.minor intValue]
                                                             identifier:@"com.fnbeacon"];
    
    // Get the beacon data to advertise
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    
    // Start the peripheral manager
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)startAdvertising:(Beacon*)beacon
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:Demo_UUID];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                  major:[beacon.major intValue]
                                                                  minor:[beacon.minor intValue]
                                                             identifier:@"com.fnbeacon"];
    
    // Get the beacon data to advertise
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    
    // Start the peripheral manager
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        // Bluetooth is on
        
        // Update our status label
        
        // Start broadcasting
        [self.peripheralManager startAdvertising:self.myBeaconData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        // Update our status label
        
        // Bluetooth isn't on. Stop broadcasting
        [self.peripheralManager stopAdvertising];
    }
    else if (peripheral.state == CBPeripheralManagerStateUnsupported)
    {
    }
}

- (IBAction)close:(id)sender
{
    if(self.peripheralManager.isAdvertising)
    {
        [self.peripheralManager stopAdvertising];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
