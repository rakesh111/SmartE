//
//  Constants.h
//  RESideMenuExample
//
//  Created by Tom Antony on 29/3/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#ifndef RESideMenuExample_Constants_h
#define RESideMenuExample_Constants_h

#define kAppName                                            @"Munchon"

#define kUniversalThemeColor                                [UIColor colorWithRed:0.1373 green:0.1216 blue:0.1255 alpha:1.0]

#define kCardBgColor                                        [UIColor colorWithRed:0.9490 green:0.9490 blue:0.9490 alpha:1.0]

//static NSString * const PiwikAskedForPermissonKey           = @"PiwikAskedForPermissonKey";

#pragma mark -

#define kBeaconsFoundNotification                           @"BeaconsFoundNotification"

#define kEnterBeaconAreaNotificationKey                     @"EnterBeaconAreaNotification"

#define kExitBeaconAreaNotificationKey                      @"ExitBeaconAreaNotification"

#define kAnalyticsTrackingEnabledKey                        @"AnalyticsTrackingEnabledKey"

#define kFacebookProfileFetchedNotification                 @"FacebookProfileFetchedNotification"

typedef enum BeaconState
{
    BeaconStateNew = 0,
    BeaconStateExisting,
    BeaconStateToBeRemoved,
} BeaconState;

#pragma mark Service constants

#define kDefaultVersion                                     @"0000-00-00 00:00:00"

#define kDescriptionKey                                     @"description"
#define kIdKey                                              @"uuid"
#define kImageurlKey                                        @"imageurl"
#define kThumbnailImageurlKey                               @"thumbnailimageurl"
#define kDetailsurlKey                                      @"detailsurl"
#define kMajorminorKey                                      @"majorminor"
#define kNameKey                                            @"name"
#define kVideourlKey                                        @"videourl"
#define kItemsKey                                           @"items"
#define kCategoriesKey                                      @"categories"
#define kYouTubeKey                                         @"youtube"
#define kMediumQualityVideoKey                              @"medium"
#define kLocationsKey                                       @"locations"
#define kImageNameKey                                       @"imagename"
#define kFloorImageKey                                      @"floorimage"
#define kLocationIdKey                                      @"locationid"
#define kFloorIdKey                                         @"floorid"
#define kXcordinateKey                                      @"xcordinate"
#define kYcordinateKey                                      @"ycordinate"
#define kVenueImageKey                                      @"venueimage"
#define kCategoryidKey                                      @"categoryid"
#define kDeviceKey                                          @"deviceKey"
#define kCardListKey                                        @"cardListKey"


#define kBeaconDetailsServiceURL                            @"http://jadoomovies.in/app/beacons/list.php?categoryid="

#define kBeaconFinderKey                                    @"beaconFinder"
#define kRegionIdKey                                        @"regionID"

#define PROXIMITY_UUID                                      @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"

#define kImageUploadFTPServerUserName                       @"sinergialabs@gmail.com"
#define kImageUploadFTPServerPassword                       @"sinergia123"

#define kInternetReachableCheckHost                         @"google.com"

#define kJSONkey                                            @"JSON"

#define SCREEN_HEIGHT                                       [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                                        [UIScreen mainScreen].bounds.size.width

#define DEVICE_VER                                          [[[UIDevice currentDevice] systemVersion] floatValue]

#define kIsiOS8Device                                       ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define kRequestTimeOutInterval                             60

#define kActivityViewTag                                    9900
#define kActivityIndicatorTag                               9901


//#define kConfigURL                                          @"https://s3-us-west-2.amazonaws.com/elasticbeanstalk-us-west-2-060425629624/munchon/service/settings.json.php"


#define kConfigURL                                          @"http://ec2-54-69-234-149.us-west-2.compute.amazonaws.com:8080/SpringServices/service/version/settings"


#define kCompletedWithFetchingResourcesAndUpdatingNotification @"CompletedWithFetchingResourcesAndUpdatingNotification"

#define kCompletedFetchingResourcesForSplash @"CompletedFetchingResourcesForSplash"

#define kResponseVOKey                                      @"responseVO"
#define kMessageKey                                         @"message"
#define kEntryMessageKey                                    @"entryMessage"
#define kExitMessageKey                                     @"exitMessage"
#define kStatusKey                                          @"status"
#define kConfigResponseKey                                  @"configResponse"
#define kBeaconDetailsKey                                   @"beaconDetails"
#define kApplicationfeeKey                                  @"applicationFee"
#define kLocalizationDetailsKey                             @"localizationDetails"
#define kBaseUrlkey                                         @"serviceBaseURL"
#define kImagePathurl                                       @"imagePathURL"
#define kLocalizationKey                                    @"localization"
#define kBeaconsKey                                         @"beacons"
//#define kBeaconsKey                                         @"beaconVersionDetails"
#define kAppVersionKey                                      @"appVersion"
#define kBeaconDetailsServiceURLKey                         @"beaconDetailsServiceURL"
#define kBeaconUDIDListKey                                  @"beaconUDIDList"
#define kFTPDetailsKey                                      @"ftpDetails"

#define kUserId                                             @"userId"
#define USER_INFO                                           @"user_infos"

#define kUsertoken                                          @"user_token"


#define kURLKey                                             @"url"
#define kPiwikDetailsKey                                    @"piwikDetails"
#define kAuthTokenKey                                       @"authToken"
#define kServerURLKey                                       @"serverURL"
#define kSiteIDKey                                          @"siteID"
#define kScreenMappingKey                                   @"screenMapping"
#define kModeKey                                            @"mode"
#define kNameKey                                            @"name"
#define kDetailsKey                                         @"details"
#define kVersionDetailsKey                                  @"versionDetails"
#define kVersionKey                                         @"version"
#define kGalleryDetailsKey                                  @"galleryDetails"
#define kGalleryKey                                         @"gallery"
#define kLocationDetailsKey                                 @"locationDetails"
#define kLatitudeKey                                        @"latitude"
#define kLongitudeKey                                       @"longitude"
#define kApplicationFolderName                              @"Munchon"
#define kHTMLFolderPath                                     @"HTML"
#define kFloorsKey                                          @"floors"
#define kDateKey                                            @"date"
#define kResourceVersionKey                                 @"ResourceVersion"
#define kResourceFileNameKey                                @"ResourceFileName"
#define kBeaconRefreshIntervalKey                           @"beaconRefreshInterval"

#define kFTPPath                                            @"ftp://jadoomovies.in/work/biennale/images/"

#define kSEkey                                              @"72d?5ve#7fa4*emi"

#define kLoggedin                                           @"Loggedin"
#define kCardEntered                                        @"Cardentered"
#define kUsername                                           @"Username"
#define kPassword                                           @"Password"
#define kUser_Fname                                         @"user_fname"
#define kUser_Lname                                         @"user_lname"
#define kUser_phone                                         @"user_phone"
#define kUser_tkn                                           @"usertoken"
#define kauthtkn                                            @"Authorization"
#define kcouponApplied                                      @"couponApplied"
#define kcouponDetails                                      @"couponDetails"

#define kChangeSplashScreeMessageNotification               @"ChangeSplashScreeMessageNotification"

#define kNoBeaconsFoundMessage @"No nearby beacons found!. Either your are not nearby Biennale location or your bluetooth is not turned on."

#define kBuildUsingXCode6                                   1

#define kEnableCaching                                      0

#define AWSAccessKey                                        @"AKIAJ3WOON2AHPXDZWVQ"
#define AWSSecretKey                                        @"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"
#define BucketName                                          @"elasticbeanstalk-us-west-2-060425629624"

#define kEnableNotificationsKey                             @"EnableNotifications"

#define kAppLaunchedForMoreThanOneTime                      @"AppLaunchedForMoreThanOneTime"

#define kKMBRedColor    [UIColor colorWithRed:0.9412 green:0.1098 blue:0.1804 alpha:1.0]
#define kKMBBlackColor  [UIColor colorWithRed:0.1294 green:0.1255 blue:0.1176 alpha:1.0]
#define kKMBGreenColor  [UIColor colorWithRed:0.7333 green:0.8353 blue:0.3333 alpha:1.0]
#define kKMBCyanColor   [UIColor colorWithRed:0.4588 green:0.8000 blue:0.7765 alpha:1.0]

#pragma mark -

#endif
