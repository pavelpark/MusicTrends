//
//  PopularSongsViewController.m
//  MusicTrends
//
//  Created by Pavel Parkhomey on 5/31/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "PopularSongsViewController.h"
#import "SpotifyAPI.h"

@interface PopularSongsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PopularSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"kAccessToken"];
    
    NSLog(@"Token %@", savedValue);
    [SpotifyAPI getArtists];
    
}


//UITableViewDataSourceMethods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    return cell;
}


@end
