//
//  LoginViewModel.m
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/9.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init {
    self = [super init];
    if(self) {
        [self bind];
    }
    return self;
}

- (void)bind{
    
    //监听账号属性值，组合成一个信号
    self.loginSignal = [RACSignal combineLatest:@[RACObserve(self, userName), RACObserve(self, password)] reduce:^id (NSString *username, NSString *password){
        NSLog(@"%@---%@",username,password);
        return @([self validUserName:username] && [self validPassWord:password]);
    }];
    
    //监听登录逻辑
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"点击了登录");
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@{@"data":@"1"}];
                // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    //监听登录的数据
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSDictionary *data = x;
        BOOL isLogin = [data objectForKey:@"data"];
        if(isLogin) {
            NSLog(@"登录成功");
        }
    }];
    
    // 监听登录状态
    [[self.loginCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            NSLog(@"正在登录ing...");
            //
            // 用蒙版提示
//            [MBProgressHUD showMessage:@"正在登录..."];
            
            
        }else {
            NSLog(@"登录成功");
            // 隐藏蒙版
//            [MBProgressHUD hideHUD];
        }
    }];
}



- (BOOL)validUserName:(NSString *)userName
{
    BOOL result=false;
    
    if ([userName length]>0) {
        result=true;
    }
    return result;
}

- (BOOL)validPassWord:(NSString *)passWord
{
    BOOL result=false;
    
    if ([passWord length] >0) {
        result=true;
    }
    return result;
}
@end
