//
//  LLLoginViewController.m
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/9.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "LLLoginViewController.h"
#import <ReactiveObjC.h>
#import "LoginViewModel.h"

@interface LLLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@implementation LLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    
    [self bindModel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.userNameTextField.frame = CGRectMake((self.view.frame.size.width - 100 )/2, 200, 100, 40);
    self.passwordTextField.frame = CGRectMake((self.view.frame.size.width - 100 )/2, 250, 100, 40);
    self.loginButton.frame = CGRectMake((self.view.frame.size.width - 100 )/2, self.view.frame.size.height - 100, 100, 50);
}

- (void)bindModel {
    
    RAC(self.loginViewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.loginViewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = self.loginViewModel.loginSignal;
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.loginViewModel.loginCommand execute:nil];
    }];
}

- (LoginViewModel *)loginViewModel
{
    if (_loginViewModel == nil) {
        
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (UITextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.delegate = self;
            textField.font = [UIFont systemFontOfSize:16];
            textField.textAlignment = NSTextAlignmentLeft;
            textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            textField.placeholder = @"请输入用户名";
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//            [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            textField;
        });
    }
    return _userNameTextField;
}


- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.delegate = self;
            textField.font = [UIFont systemFontOfSize:16];
            textField.textAlignment = NSTextAlignmentLeft;
            textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            textField.placeholder = @"请输入密码";
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//            [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            textField;
        });
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _loginButton.backgroundColor =[UIColor blueColor];
    }
    return _loginButton;
}
@end
