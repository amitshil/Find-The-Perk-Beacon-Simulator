//
//  Beacon.h
//  FindThePerkBeacon
//
//  Created by Amit Shil on 17/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beacon : NSObject

@property (nonatomic, strong) NSString *bgImage;
@property (nonatomic, strong) NSString *actionText;
@property (nonatomic, strong) NSNumber *major;
@property (nonatomic, strong) NSNumber *minor;

@end
