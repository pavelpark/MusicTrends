//
//  SpotifyAPI.m
//  MusicTrends
//
//  Created by Pavel Parkhomey on 6/8/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "SpotifyAPI.h"

@implementation SpotifyAPI

+ (void)getArtists{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject];
    
    //Endpoint for getting current user's playlist
    NSURL *url = [NSURL URLWithString:@"https://api.spotify.com/v1/me/top/artists"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"kAccessToken"];
    NSString *authString = [NSString stringWithFormat:@"Bearer %@", accessToken];
    [request setValue:authString forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error Fetching %@", error.localizedDescription);
        }
        NSLog(@"Response Code: %@", response);
        
      
        
    }];
    
    [dataTask resume];
}@end
