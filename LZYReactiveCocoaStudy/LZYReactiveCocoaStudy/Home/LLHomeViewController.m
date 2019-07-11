//
//  LLHomeViewController.m
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/9.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "LLHomeViewController.h"
#import "LLHomeViewModel.h"
#import "BookModel.h"

@interface LLHomeViewController () <UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) LLHomeViewModel *requsetViewModel;
@end

@implementation LLHomeViewController

- (LLHomeViewModel *)requsetViewModel {
    if (!_requsetViewModel) {
        _requsetViewModel = [[LLHomeViewModel alloc] init];
    }
    return _requsetViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建tableView
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.backgroundColor = [UIColor whiteColor];
    self.table.dataSource = self;
    
    [self.view addSubview:self.table];
    
    RACSignal *signal = [self.requsetViewModel.requestCommand execute:nil];
    [signal subscribeNext:^(id  _Nullable x) {
        self.models = x;
        
        [self.table reloadData];
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    BookModel *book = self.models[indexPath.row];
    cell.textLabel.text = book.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",book.price];
    
    return cell;
}
 

@end
