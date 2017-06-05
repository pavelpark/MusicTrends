//
//  AppDelegate.h
//  MusicTrends
//
//  Created by Pavel Parkhomey on 5/30/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>
#import <SafariServices/SafariServices.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, SPTAudioStreamingDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

