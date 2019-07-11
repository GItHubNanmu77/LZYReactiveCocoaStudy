//
//  LLTipView.m
//  LZYReactiveCocoaStudy
//
//  Created by cisdi on 2019/7/10.
//  Copyright © 2019 lzy. All rights reserved.
//

#import "LLTipView.h"


@interface LLTipView ()
@property (nonatomic, strong) UIButton *btnConfirm;
@end

@implementation LLTipView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.btnConfirm];
        
    }
    return self;
}

- (UIButton *)btnConfirm {
    if (!_btnConfirm) {
        __weak typeof(self) weakSelf = self;
        _btnConfirm = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
            button.showsTouchWhenHighlighted = YES;
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitle:@"确认" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor redColor]];
            button.layer.cornerRadius = 4;
            [button addTarget:weakSelf action:@selector(btnConfirmAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _btnConfirm;
}
- (void)btnConfirmAction {
    NSLog(@"按钮点击");
}
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
@end
