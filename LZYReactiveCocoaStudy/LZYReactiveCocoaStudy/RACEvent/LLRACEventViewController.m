//
//  LLRACEventViewController.m
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/10.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "LLRACEventViewController.h"
#import "Person.h"
#import <ReactiveObjC.h>

@interface LLRACEventViewController ()
@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) RACDelegateProxy *proxy;
@end

@implementation LLRACEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    
    [self demoKvo];
    [self demoTextField];
    [self textFileCombination];
    [self buttonDemo];
    [self delegateDemo];
    [self notificationDemo];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.nameLabel.frame = CGRectMake((self.view.frame.size.width - 100 )/2, 170, 100, 20);
    self.userNameTextField.frame = CGRectMake((self.view.frame.size.width - 100 )/2, 200, 100, 40);
    self.passwordTextField.frame = CGRectMake((self.view.frame.size.width - 100 )/2, 250, 100, 40);
    self.loginButton.frame = CGRectMake((self.view.frame.size.width - 100 )/2, self.view.frame.size.height - 100, 100, 50);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person.name = [NSString stringWithFormat:@"zhang %d",arc4random_uniform(100)];
}

/**
 * 1、为了测试此函数，增加了一个Person类 && 一个Label；点击屏幕则会等改Lable的值
 */
#pragma -mark KVO 监听
- (void)demoKvo {
    @weakify(self)
    [RACObserve(self.person, name)
     subscribeNext:^(id x) {
         @strongify(self)
         self.nameLabel.text = x;
     }];
}

#pragma -mark 文本框输入事件监听
/**
 * 2、为了测试此函数，增加了一个nameText；监听文本框的输入内容，并设置为self.person.name
 */
- (void)demoTextField {
    @weakify(self)
    
    [[self.userNameTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        NSLog(@"%@",x);
        self.person.name = x;
    }];
}

#pragma -mark 文本信号组合
/**
 * 3、为了验证此函数，增加了一个passwordText和一个Button，监测nameText和passwordText
 * 根据状态是否enabled
 */
- (void)textFileCombination {
    
    id signals = @[[self.userNameTextField rac_textSignal],[self.passwordTextField rac_textSignal]];
    
    @weakify(self);
    [[RACSignal
      combineLatest:signals]
     subscribeNext:^(RACTuple *x) {
         
         @strongify(self);
         NSString *name = [x first];
         NSString *password = [x second];
         
         if (name.length > 0 && password.length > 0) {
             
             self.loginButton.enabled = YES;
             self.person.name = name;
             self.person.password = password;
             
         } else  {
             self.loginButton.enabled = NO;
             
         }
     }];
}

#pragma -mark 按钮监听
/**
 * 4、验证此函数：当loginButton可以点击时，点击button输出person的属性，实现监控的效果
 */
- (void)buttonDemo {
    @weakify(self);
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         NSLog(@"person.name:  %@    person.password:  %@",self.person.name,self.person.password);
     }
     ];
}

#pragma -mark 代理方法
/**
 * 5、验证此函：nameText的输入字符时，输入回撤或者点击键盘的回车键使passWordText变为第一响应者（即输入光标移动到passWordText处）
 */
- (void)delegateDemo {
    @weakify(self)
    
    self.proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextFieldDelegate)];
    // 2. 代理去注册文本框的监听方法
    [[self.proxy rac_signalForSelector:@selector(textFieldShouldReturn:)]
     subscribeNext:^(id x) {
         @strongify(self)
         if (self.userNameTextField.hasText) {
             [self.passwordTextField becomeFirstResponder];
         }
     }];
    self.userNameTextField.delegate = (id<UITextFieldDelegate>)self.proxy;
}


#pragma -mark 通知
/**
 * 验证此函数：点击textFile时，系统键盘会发送通知，打印出通知的内容
 */
- (void)notificationDemo {
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil]
     subscribeNext:^(id x) {
         NSLog(@"notificationDemo : %@", x);
     }
     ];
}
#pragma -mark Getter
- (Person *)person {
    if(!_person) {
        _person = [[Person alloc] init];
    }
    return _person;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor blackColor];
            label;
        });
    }
    return _nameLabel;
}

- (UITextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = ({
            UITextField *textField = [[UITextField alloc] init];
//            textField.delegate = self;
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
//            textField.delegate = self;
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
        [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _loginButton.backgroundColor = [UIColor blueColor];
    }
    return _loginButton;
}
@end
