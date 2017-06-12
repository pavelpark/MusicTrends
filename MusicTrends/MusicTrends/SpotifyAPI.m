//
//  SpotifyAPI.m
//  MusicTrends
//
//  Created by Pavel Parkhomey on 6/8/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "SpotifyAPI.h"

@implementation SpotifyAPI


+(void)getArtistsWithCompletion:(TopArtistsCompletionHandler)completion{
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
            completion(error, nil);
        }
        NSLog(@"Response Code: %@", response);
        
        NSDictionary *topArtistJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"TOP ARTIST: %@", topArtistJSON);
        
        NSMutableArray *allArtists =[[NSMutableArray alloc]init];
        
        //Breakes down a big dictionary into smaller ones.
        for (NSDictionary *artistDictionary in [topArtistJSON valueForKey:@"items"]) {
            NSLog(@"______________________ %@", artistDictionary[@"name"]);
            
            
            NSDictionary *artistObject = @{
                                           @"name" : artistDictionary[@"name"],
                                           @"spotifyURL" : artistDictionary[@"href"],
                                           @"artistID" : artistDictionary[@"id"]
                                           };
            [allArtists addObject:artistObject];
        }
            //            NSLog(@"ARTIST DIC %@", artistDictionary);
           

            
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion (error,[allArtists copy]);
            });
        }
                                      
    }];
    [dataTask resume];
    
}
@end
