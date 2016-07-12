//
//  ServiceTools.h
//  Mazlusek
//
//  Created by Jan Damek on 08.07.16.
//  Copyright © 2016 Jan Damek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceTools : NSObject

+(void) GADInitialization:(GADBannerView*)bannerView rootViewController:(UIViewController*)rootViewController;
+(NSString *)calcBMIfromWeight:(NSString *)weight height:(NSString *)height;
+(NSString *)calcBMIfromWeightFloat:(float)weight heightInt:(int)height;
@end
