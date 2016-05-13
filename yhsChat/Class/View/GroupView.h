//
//  GroupView.h
//  yhsChat
//
//  Created by 姚海深 on 16/5/12.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupView : UIView

- (id)initWithFrame:(CGRect)frame clickHandler:(void(^)(NSInteger num)) block;

@end
