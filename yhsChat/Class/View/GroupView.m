//
//  GroupView.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/12.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "GroupView.h"

typedef void (^block) (NSInteger num);

@interface GroupView()

@property (nonatomic, copy)block myblock;

@end

@implementation GroupView

- (id)initWithFrame:(CGRect)frame clickHandler:(void (^)(NSInteger))block{
    self = [super initWithFrame:frame];
    if (self ) {
        self.myblock = block;
        self.backgroundColor = [UIColor blackColor];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 80, 50)];
        [button setTitle:@"好友申请" forState:UIControlStateNormal];
        button.tag = 51;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}

- (void)clickButton:(UIButton*)sender{
    self.myblock(sender.tag);
}

@end
