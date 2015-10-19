//
//  BeaconFinder.m
//  RESideMenuExample
//
//  Created by Tom Antony on 14/10/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeaconFinder.h"

//#import "DataManager.h"

@implementation BeaconFinder

- (id)initWithBeaonIdentifier:(NSString *)beaconIdentifier andRegionIdentifer:(NSString *)regionIdentifier
{
    self = [super init];
    
    if (self)
    {        
        locationManager = [[CLLocationManager alloc] init];
        

        
#if(kBuildUsingXCode6)
        if(kIsiOS8Device && [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [locationManager requestAlwaysAuthorization];
        }
#endif
        
        locationManager.delegate = self;
        
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:beaconIdentifier];
                
        if(uuid && regionIdentifier)
        {
            beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:regionIdentifier];
        
            beaconRegion.notifyOnEntry = YES;
        
            beaconRegion.notifyOnExit = YES;
        
            [locationManager startMonitoringForRegion:beaconRegion];
        
            [self locationManager:locationManager didStartMonitoringForRegion:beaconRegion];
        }
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    if(beaconRegion)
    {
        [manager startRangingBeaconsInRegion:beaconRegion];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSString *entryMessageKey = nil;
    
    if(beaconRegion)
    {
        [manager startRangingBeaconsInRegion:beaconRegion];
    }
    
    NSString *uuid =  [region identifier];
    
    NSString *message = nil;
    
    if(uuid)
    {
        entryMessageKey = [NSString stringWithFormat:@"ENTRY~%@",uuid];
    }
    
//    if(entryMessageKey && [[DataManager sharedDataManager] objectInUserDefaultsForKey:entryMessageKey])
//    {
//        message = [[DataManager sharedDataManager] objectInUserDefaultsForKey:entryMessageKey];
//    }
    
    if(message && [message length])
    {
        if([self.delegate respondsToSelector:@selector(showLocalNotificationWithMessage:)])
        {
            [self.delegate showLocalNotificationWithMessage:[NSString stringWithFormat:@"##%@",message]];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    if(beaconRegion)
    {
        [manager stopRangingBeaconsInRegion:beaconRegion];
    }
    
    NSString *uuid =  [region identifier];
    
    NSString *message = nil;
    
    NSString *exitMessageKey = nil;
    
    if(uuid)
    {
        exitMessageKey = [NSString stringWithFormat:@"EXIT~%@",uuid];
    }

//    if(exitMessageKey && [[DataManager sharedDataManager] objectInUserDefaultsForKey:exitMessageKey])
//    {
//        message = [[DataManager sharedDataManager] objectInUserDefaultsForKey:exitMessageKey];
//    }
    
    if(message && [message length])
    {
        if([self.delegate respondsToSelector:@selector(showLocalNotificationWithMessage:)])
        {
            [self.delegate showLocalNotificationWithMessage:[NSString stringWithFormat:@"##%@",message]];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSUUID *UUID = [region proximityUUID];
    
    NSString *proximityUUID = [UUID UUIDString];
    
    NSMutableArray *filteredBeacons = [self filterBeacons:beacons];
    
    if([self.delegate respondsToSelector:@selector(didFoundBeacons:withIdentifier:)])
    {
        [self.delegate didFoundBeacons:filteredBeacons withIdentifier:proximityUUID];
    }
}

- (NSMutableArray *)filterBeacons:(NSArray *)beacons
{
    NSMutableArray *filteredBeacons = [[NSMutableArray alloc] init];
    
    for(CLBeacon *beacon in beacons)
    {
        if(beacon.accuracy > 0 && beacon.accuracy <= 10.0)
        {
            [filteredBeacons addObject:beacon];
        }
    }
    
    return filteredBeacons;
}

#pragma mark - 

- (CLLocationManager *)locationManager
{
    return locationManager;
}

@end
