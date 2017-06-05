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
    self.player = [SPTAudioStreamingController sharedInstance];
    
    self.auth.clientID = @"f974e9e0a67f4cd6bca29adde6176954";
    self.auth.redirectURL = [NSURL URLWithString:@"MusicTrends://returnAfterLogin"];
    
    self.auth.sessionUserDefaultsKey = @"current session";
    self.auth.requestedScopes = @[SPTAuthStreamingScope];
    
    self.player.delegate = self;
    
    NSError *audioStreamingInitError;
    
    NSAssert([self.player startWithClientId:self.auth.clientID error:&audioStreamingInitError],
             @"There was a problem starting the Spotify SDK: %@", audioStreamingInitError.description);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startAuthenticationFlow];
        
    });
    
    return YES;
}

//We check if the session is valid, if it is valid we run the music player view.
- (void)startAuthenticationFlow {
    
    if ([self.auth.session isValid]) {

        [self.player loginWithAccessToken:self.auth.session.accessToken];
        
    } else {

        NSURL *authURL = [self.auth spotifyWebAuthenticationURL];

        self.authViewController = [[SFSafariViewController alloc] initWithURL:authURL];
        [self.window.rootViewController presentViewController:self.authViewController animated:YES completion:nil];
    }
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {

    if ([self.auth canHandleURL:url]) {
        [self.authViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        self.authViewController = nil;
        //Parse the incoming url to a session object
        [self.auth handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            if (session) {
                //login the user to the player
                [self.player loginWithAccessToken:self.auth.session.accessToken];
            }
        }];
        return YES;
    }
    return NO;
}

- (void)audioStreamingDidLogin:(SPTAudioStreamingController *)audioStreaming {
    [self.player playSpotifyURI:@"spotify:track:58s6EuEYJdlb0kO7awm3Vp" startingWithIndex:0 startingWithPosition:0 callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** failed to play: %@", error);
            return;
        }
    }];
}



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
