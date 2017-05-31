//
//  PopularSongsViewController.m
//  MusicTrends
//
//  Created by Pavel Parkhomey on 5/31/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

#import "PopularSongsViewController.h"

@interface PopularSongsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PopularSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - UITableView DataSource Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    return cell;
}
@end
