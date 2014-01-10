//
//  comBannerViewController.m
//  BMI Calculator
//
//  Created by Jan Damek on 23.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "comBannerView.h"
#import "comAppDelegate.h"

@interface comBannerView ()

@end


@implementation comBannerView

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

NSString *MY_BANNER_UNIT_ID = @"ca-app-pub-9508528448741167/3618895050";

+(GADBannerView*)getBanerView:(UIViewController*)rootViewController {
    
    GADBannerView *bannerView_;
    if (IDIOM == IPAD) {
        bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeLeaderboard];
    } else
        bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;
    
    bannerView_.rootViewController = rootViewController;
    
    [bannerView_ loadRequest:[GADRequest request]];
    return  bannerView_;
}

@end
