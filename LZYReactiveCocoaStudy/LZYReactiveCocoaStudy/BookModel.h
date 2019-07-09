//
//  BookModel.h
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/9.
//  Copyright © 2019 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat price;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
