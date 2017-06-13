//
//  AppDelegate.m
//  MusicTrends
//
//  Created by Pavel Parkhomey on 5/30/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property(strong, nonatomic) SPTAuth *auth;
@property(strong, nonatomic) SPTAudioStreamingController *player;
@property(strong, nonatomic) UIViewController *authViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.auth = [SPTAuth defaultInstance];
    self.auth.clientID = @"f974e9e0a67f4cd6bca29adde6176954";
    self.auth.redirectURL = [NSURL URLWithString:@"MusicTrends://returnAfterLogin"];
    
    self.auth.sessionUserDefaultsKey = @"current session";
    self.auth.requestedScopes = @[SPTAuthUserReadTopScope];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startAuthenticationFlow];
        
    });
    
    return YES;
}
//We check if the session is valid, if it is valid we run the music player view.
- (void)startAuthenticationFlow {
    
    if ([self.auth.session isValid]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.auth.session.accessToken forKey:@"kAccessToken"];
        
    } else {
        
        NSURL *authURL = [self.auth spotifyWebAuthenticationURL];
        
        self.authViewController = [[SFSafariViewController alloc] initWithURL:authURL];
        [self.window.rootViewController presentViewController:self.authViewController animated:YES completion:nil];
    }
}
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    
    [self.authViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    self.authViewController = nil;
    
    //Parse the incoming url to a session object
    [self.auth handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
        [[NSUserDefaults standardUserDefaults] setObject:self.auth.session.accessToken forKey:@"kAccessToken"];
        
    }];
    return YES;
    
}

//- (NSString *)accessTokenFromString:(NSString *)string {
//    if ([string containsString:@"access_token"]) {
//        NSArray *comps = [string componentsSeparatedByString:@"#"];
//        for (NSString *comp in comps) {
//            if ([comp containsString:@"access_token"]) {
//                NSArray *equals = [comp componentsSeparatedByString:@"="];
//                
//                NSString *token = [equals[1] componentsSeparatedByString:@"&"][0];
//                return token;
//            }
//        }
//        
//    }
//    return nil;
//}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
