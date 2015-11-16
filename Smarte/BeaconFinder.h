//
//  BeaconFinder.h
//  RESideMenuExample
//
//  Created by Tom Antony on 14/10/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"

@protocol BeaconFinderDelegate <NSObject>

- (void)showLocalNotificationWithMessage:(NSString *)message;
- (void)didFoundBeacons:(NSArray *)beacons withIdentifier:(NSString *)identifier;

@end

@interface BeaconFinder : NSObject <CLLocationManagerDelegate>
{    
    CLLocationManager *locationManager;
    
    
    CLBeaconRegion *beaconRegion;
}

- (id)initWithBeaonIdentifier:(NSString *)beaconIdentifier andRegionIdentifer:(NSString *)regionIdentifier;

- (CLLocationManager *)locationManager;

@property(nonatomic, retain)id <BeaconFinderDelegate> delegate;

@end
