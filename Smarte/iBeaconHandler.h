//
//  iBeaconHandler.h
//  RESideMenuExample
//
//  Created by Tom Antony on 4/8/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BeaconFinder.h"

@protocol iBeaconHandlerDelegate <NSObject>

- (void)showLocalNotificationWithMessage:(NSString *)message;
- (void)didFoundBeacons:(NSArray *)beacons;

@end

@interface iBeaconHandler : UIView <BeaconFinderDelegate>
{
    NSMutableArray *consolidatedFoundBeacons;
    
    NSMutableDictionary *trackedBeacons;
    
    NSMutableArray *beaconFinders;
}

+ (iBeaconHandler*)sharedBeaconHandler;

- (void)startTrackingBeaconsWithID:(NSString *)beaconId;

- (void)requestAlwaysAuthorization;

@property(nonatomic, retain)id <iBeaconHandlerDelegate> delegate;

@end
