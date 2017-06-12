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

@property (weak, nonatomic) NSArray<NSDictionary *> *artistObj;
@end

@implementation PopularSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"kAccessToken"];
    
    NSLog(@"Token %@", savedValue);
    [SpotifyAPI getArtistsWithCompletion:^(NSError *error, NSArray<NSDictionary *> *artistsObjects) {
        self.artistObj = artistsObjects;
        //todo:reload [self.tableView reloadData]; Once the data is parsed.
    }];
    
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
