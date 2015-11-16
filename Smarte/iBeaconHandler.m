//
//  iBeaconHandler.m
//  RESideMenuExample
//
//  Created by Tom Antony on 4/8/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "iBeaconHandler.h"

@implementation iBeaconHandler

static iBeaconHandler* sharedHandler;

+ (iBeaconHandler*)sharedBeaconHandler
{
    if (sharedHandler == nil)
    {
        sharedHandler = [[super allocWithZone:NULL] init];
    }
    
    return sharedHandler;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        consolidatedFoundBeacons = [[NSMutableArray alloc] init];
        
        beaconFinders = [[NSMutableArray alloc] init];
        
        trackedBeacons = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)startTrackingBeaconsWithID:(NSString *)beaconId
{    
    BeaconFinder *beaconFinder = [[BeaconFinder alloc] initWithBeaonIdentifier:beaconId andRegionIdentifer:beaconId];
    
    beaconFinder.delegate = self;
    
    [beaconFinders addObject:beaconFinder];
}

#if(kBuildUsingXCode6)

- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied)
    {
        NSString *title;
        
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        
        NSString *message = @"To Use Background Location You Must Turn On 'Always' In The Location Services Settings";
        
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    else if (status == kCLAuthorizationStatusNotDetermined)
    {
        [self requestAlwaysAuthorizationForAllLocationManagerInstances];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        //[[UIApplication sharedApplication] openURL:settingsURL];
    }
}

- (void)requestAlwaysAuthorizationForAllLocationManagerInstances
{
    for (BeaconFinder *beaconFinder in beaconFinders)
    {
        CLLocationManager *locationManager = (CLLocationManager *)[beaconFinder locationManager];
            
        [locationManager requestAlwaysAuthorization];
    }
}

#endif

#pragma mark Delegate methods

- (void)showLocalNotificationWithMessage:(NSString *)message
{
    if([self.delegate respondsToSelector:@selector(showLocalNotificationWithMessage:)])
        [self.delegate showLocalNotificationWithMessage:message];
}

- (void)didFoundBeacons:(NSArray *)beacons withIdentifier:(NSString *)identifier
{
    [trackedBeacons setObject:beacons forKey:identifier];
    
    if([consolidatedFoundBeacons count])
    {
        [consolidatedFoundBeacons removeAllObjects];
    }
    
    
    for (int i = 0; i < [[trackedBeacons allKeys] count]; i++)
    {
        NSString *key = [[trackedBeacons allKeys] objectAtIndex:i];
        
        NSMutableArray *trackedBeaconList = [trackedBeacons objectForKey:key];
        
        [consolidatedFoundBeacons addObjectsFromArray:trackedBeaconList];
    }
    
    if([self.delegate respondsToSelector:@selector(didFoundBeacons:)])
    {
        [self.delegate performSelector:@selector(didFoundBeacons:) withObject:consolidatedFoundBeacons];
    }
    
    
}

#pragma mark -

@end
