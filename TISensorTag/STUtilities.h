//
//  STUtilities.h
//  TISensorTag
//
//  Created by Andre Muis on 11/14/13.
//  Copyright (c) 2013 Andre Muis. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

@interface STUtilities : NSObject

+ (float)vectorMagnitudeWithXComponent: (float)xComponent YComponent: (float)yComponent ZComponent: (float)zComponent;

+ (float)farenheitWithCelsius: (float)celsius;

+ (NSString *)stringWithCBUUID: (CBUUID *)uuid;

@end
