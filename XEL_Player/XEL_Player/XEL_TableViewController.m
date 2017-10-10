//
//  XEL_TableViewController.m
//  XEL_Player
//
//  Created by xiaoerlong on 2017/10/7.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XEL_TableViewController.h"
#import "XEL_TableViewCell.h"
#import "XEL_PlayerView.h"

@interface XEL_TableViewController ()

@end

@implementation XEL_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 201;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XEL_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    return cell;
}

@end
