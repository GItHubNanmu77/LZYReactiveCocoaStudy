//
//  BookModel.m
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/9.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.price = [[dict objectForKey:@"price"] floatValue];
    }
    return self;
}
@end
