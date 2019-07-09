//
//  LLHomeViewModel.m
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/9.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "LLHomeViewModel.h"

@interface LLHomeViewModel () 

@end
@implementation LLHomeViewModel

- (instancetype)init
{
    if (self = [super init]) {
        
        [self initialBind];
    }
    return self;
}


- (void)initialBind {
    self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSMutableDictionary *data = [NSMutableDictionary dictionary];
            data[@"books"] = @[@{@"name":@"stat1",@"price":@(3.00)},
                                     @{@"name":@"stat2",@"price":@(13.00)},
                                     @{@"name":@"stat3",@"price":@(23.00)},
                                     @{@"name":@"stat4",@"price":@(33.00)},];
            // 发送请求
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 请求成功调用
                // 把数据用信号传递出去
                [subscriber sendNext:data];
                
                [subscriber sendCompleted];
            });
            return nil;
        }];
        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [signal map:^id(NSDictionary *value) {
            NSMutableArray *dictArr = value[@"books"];
            
            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                
                return [[BookModel alloc] initWithDict:value];
                
            }] array];
            
            return modelArr;
        }];
    }];
}



@end
