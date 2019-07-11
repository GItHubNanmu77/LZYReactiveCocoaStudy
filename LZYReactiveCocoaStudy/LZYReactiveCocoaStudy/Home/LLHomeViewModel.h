//
//  LLHomeViewModel.h
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/9.
//  Copyright © 2019 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "BookModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLHomeViewModel : NSObject 

@property (nonatomic, strong) RACCommand *requestCommand;

@end

NS_ASSUME_NONNULL_END
