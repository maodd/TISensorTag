//
//  STAccelerometer.m
//  TISensorTag
//
//  Created by Andre Muis on 11/14/13.
//  Copyright (c) 2013 Andre Muis. All rights reserved.
//

#import "STAccelerometer.h"

#import "STAcceleration.h"
#import "STConstants.h"

@interface STAccelerometer ()

@property (readonly, strong, nonatomic) CBPeripheral *sensorTagPeripheral;

@end

@implementation STAccelerometer

- (id)initWithSensorTagPeripheral: (CBPeripheral *)sensorTagPeripheral
{
    self = [super init];
    
    if (self)
    {
        _sensorTagPeripheral = sensorTagPeripheral;
        
        _dataCharacteristicUUID = [CBUUID UUIDWithString: STAccelerometerDataCharacteristicUUIDString];
        _dataCharacteristic = nil;
        
        _configurationCharacteristicUUID = [CBUUID UUIDWithString: STAccelerometerConfigurationCharacteristicUUIDString];
        _configurationCharacteristic = nil;
        
        _periodCharacteristicUUID = [CBUUID UUIDWithString: STAccelerometerPeriodCharacteristicUUIDString];
        _periodCharacteristic = nil;
    }
    
    return self;
}

- (BOOL)configured
{
    if (self.dataCharacteristic != nil &&
        self.configurationCharacteristic != nil &&
        self.periodCharacteristic != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)update
{
    uint8_t periodData = (uint8_t)(500 / 10);
    [self.sensorTagPeripheral writeValue: [NSData dataWithBytes: &periodData length: 1]
                       forCharacteristic: self.periodCharacteristic
                                    type: CBCharacteristicWriteWithResponse];

    uint8_t data = 0x01;
    [self.sensorTagPeripheral writeValue: [NSData dataWithBytes: &data length: 1]
                       forCharacteristic: self.configurationCharacteristic
                                    type: CBCharacteristicWriteWithResponse];
 
    [self.sensorTagPeripheral setNotifyValue: YES
                           forCharacteristic: self.dataCharacteristic];
}

- (STAcceleration *)accelerationWithCharacteristicValue: (NSData *)characteristicValue
{
    char scratchVal[characteristicValue.length];
    [characteristicValue getBytes: &scratchVal length: 3];
    
    STAcceleration *acceleration = [[STAcceleration alloc] initWithXComponent: (scratchVal[0] * 1.0) / (256 / STAccelerometerRange)
                                                                   YComponent: (scratchVal[1] * 1.0) / (256 / STAccelerometerRange)
                                                                   ZComponent: (scratchVal[2] * 1.0) / (256 / STAccelerometerRange)];
    
    return acceleration;
}

@end

















