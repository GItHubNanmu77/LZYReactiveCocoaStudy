//
//  ViewController.m
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/8.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "LLLoginViewController.h"
#import "LLHomeViewController.h"
#import "LLRACEventViewController.h"
#import "LLRACClassViewController.h"
#import "LLTipView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.logoutButton];
    
    [self.view addSubview:self.table];
    
}
#pragma  mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        LLRACClassViewController *vc = [[LLRACClassViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        LLRACEventViewController *vc = [[LLRACEventViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        LLHomeViewController *vc = [[LLHomeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        LLTipView *tipView = [[LLTipView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        [tipView show];
    }
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor whiteColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableFooterView = self.logoutButton;
    }
    return _table;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:@"RAC基础类"];
        [_dataSource addObject:@"RAC事件"];
        [_dataSource addObject:@"RAC列表"];
    }
    return _dataSource;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        [_logoutButton setTitle:@"退出" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _logoutButton.backgroundColor = [UIColor blueColor];
        [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _logoutButton;
}


-(void)logout{
    LLLoginViewController *vc = [[LLLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
