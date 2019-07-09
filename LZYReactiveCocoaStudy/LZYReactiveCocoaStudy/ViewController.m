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

@interface ViewController ()

@property (nonatomic, strong) UIButton *logoutButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.logoutButton];
    
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 400, 100, 50)];
        [_logoutButton setTitle:@"退出" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _logoutButton.backgroundColor =[UIColor blueColor];
        [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _logoutButton;
}

-(void)logout{
    LLHomeViewController *vc = [[LLHomeViewController alloc] init];
//    LLLoginViewController *vc = [[LLLoginViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
