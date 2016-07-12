//
//  ServiceTools.m
//  Mazlusek
//
//  Created by Jan Damek on 08.07.16.
//  Copyright © 2016 Jan Damek. All rights reserved.
//

@import GoogleMobileAds;

#import "ServiceTools.h"

@implementation ServiceTools

+(void) GADInitialization:(GADBannerView*)bannerView rootViewController:(UIViewController*)rootViewController{
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    bannerView.adUnitID = @"ca-app-pub-9508528448741167/2142161857";
    bannerView.rootViewController = rootViewController;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"d94f56a29a7713c484d0cd4ae758cadb", @"213a4715eaba991fe83e5f35db3e3bc6" ];
    [bannerView loadRequest:request];
}

+(NSString *)calcBMIfromWeight:(NSString *)weight height:(NSString *)height{
    float heightInt = [height floatValue]/100;
    float weightFlt = [weight floatValue];
    float heightFlt = heightInt * heightInt ;
    float bmi = weightFlt / heightFlt;
    return [NSString stringWithFormat:@"%.02f", bmi];
}
+(NSString *)calcBMIfromWeightFloat:(float)weight heightInt:(int)height{
    NSString* weightStr = [NSString stringWithFormat:@"%f",weight];
    NSString* heightStt = [NSString stringWithFormat:@"%i",height];
    return [ServiceTools calcBMIfromWeight:weightStr height:heightStt];
}

@end
