//
//  SpotifyAPI.h
//  MusicTrends
//
//  Created by Pavel Parkhomey on 6/8/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotifyAPI : NSObject

typedef void(^TopArtistsCompletionHandler)(NSError *error, NSArray<NSDictionary *>* artistsObjects);

+(void)getArtistsWithCompletion:(TopArtistsCompletionHandler)completion;

@end
