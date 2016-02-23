//
//  AppDelegate.m
//  objc-Foursquare
//
//  Created by Zachary Drossman on 10/20/14.
//  Copyright (c) 2014 Zachary Drossman. All rights reserved.
//

#import "AppDelegate.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "Foursquare2.h"
#import "FISPrivateInfo.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Do not alter ////////////////////////////////////////////////////////////
    if (isRunningTests()) {
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            if ([request.URL.host isEqualToString:@"api.foursquare.com"]&&[request.URL.path isEqualToString:@"/v2/venues/search"]) {
                return YES;
            } else {
                return NO;
            }
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"foursquareResultsStub.json", [NSBundle mainBundle]) statusCode:200 headers:@{@"Content-Type": @"application/json"}];
        }];
    } //////////////////////////////////////////////////////////////////////////
    // Override point for customization after application launch.
    
    [Foursquare2 setupFoursquareWithClientId:FoursquareAPIClientId
                                      secret:FoursquareAPIClientSecret
                                 callbackURL:FoursquareAPICallbackURL];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

static BOOL isRunningTests(void)
{
    NSDictionary* environment = [[NSProcessInfo processInfo] environment];
    NSString* injectBundle = environment[@"XCInjectBundle"];
    return [[injectBundle pathExtension] isEqualToString:@"xctest"];
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [Foursquare2 handleURL:url];
}

@end
