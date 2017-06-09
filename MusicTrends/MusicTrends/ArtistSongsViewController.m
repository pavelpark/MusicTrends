//
//  ArtistSongsViewController.m
//  MusicTrends
//
//  Created by Pavel Parkhomey on 6/8/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "ArtistSongsViewController.h"

@interface ArtistSongsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;
@end

@implementation ArtistSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
