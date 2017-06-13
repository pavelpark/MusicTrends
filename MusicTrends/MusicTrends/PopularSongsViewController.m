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

@property (strong, nonatomic) NSArray<NSDictionary *> *artistObj;
@end

@implementation PopularSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"kAccessToken"];
    
    NSLog(@"Token %@", savedValue);
    [SpotifyAPI getArtistsWithCompletion:^(NSError *error, NSArray<NSDictionary *> *artistsObjects) {
        self.artistObj = artistsObjects;
        [self.tableView reloadData];
        NSLog(@"********* %@", self.artistObj[0]);
        NSLog(@"Keys: %@", [self.artistObj[2] allValues]);
        NSLog(@"** object type %@", [self.artistObj[0] class]);
    }];
    
}


//UITableViewDataSourceMethods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.artistObj.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    NSLog(@"Artist OBJ: %@", self.artistObj[0]);
//    NSLog(@"Artist: %@", [self.artistObj[indexPath.row] valueForKey:@"name"]);
    cell.textLabel.text = [self.artistObj[indexPath.row] valueForKey:@"name"];
    
    return cell;
}


@end
