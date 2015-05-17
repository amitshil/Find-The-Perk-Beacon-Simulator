//
//  EventsViewController.h
//  FindThePerkBeacon
//
//  Created by Amit Shil on 17/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController<UITextFieldDelegate,CBPeripheralManagerDelegate>

@end
