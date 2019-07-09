//
//  LoginViewModel.h
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/9.
//  Copyright © 2019 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *asstoken;

@property (nonatomic, strong) RACSignal *loginSignal;
@property (nonatomic, strong) RACCommand *loginCommand;
@end

NS_ASSUME_NONNULL_END
