//
//  comAppDelegate.m
//  BMI Calculator
//
//  Created by Jan Damek on 23.12.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "comAppDelegate.h"
#import "Entrys.h"

@interface comAppDelegate () {
    BOOL lastPoirtrait;
}
@end

@implementation comAppDelegate

@synthesize data = _data;

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

-(NSString*)getFileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    return filePath;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    lastPoirtrait = NO;
    lastPoirtrait = [self isPortrait];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //    [_data writeToFile:[self getFileName] atomically:YES];
    [self storeData];
}

-(void)storeData{
    _data = [[NSMutableArray alloc] initWithArray:[_data sortedArrayUsingSelector:@selector(compare:)]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_data];
    NSString *path = [self getFileName];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSMutableArray*)getData{
    if (!_data){
        NSString *path = [self getFileName];
        @try {
            _data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            _data = [[NSMutableArray alloc] initWithArray:[_data sortedArrayUsingSelector:@selector(compare:)]];
        }
        @catch (NSException *exception) {
            _data = nil;
        }
        if (!_data) {
            _data = [[NSMutableArray alloc] init];
        }
    }
    
    return _data;
}

-(BOOL)isPortrait{
    lastPoirtrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
    return lastPoirtrait;
}

-(BOOL)isIPad{
    return (IDIOM == IPAD);
}

@end
