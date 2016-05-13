//
//  ViewController.h
//  yhsChat
//
//  Created by 姚海深 on 16/5/11.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)setNavigation:(NSString *)title rightButton:(NSString *)rightTitle andNeedLeftButton:(BOOL) leftNeed;
- (void)leftClick:(UIButton *)button;
- (void)rightClick:(UIButton *)button;

@end

