//
//  LoginViewController.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/11.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "LoginViewController.h"
#import "EMSDK.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)loginClick:(id)sender {
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.userName.text  password:self.password.text];
    if (!error) {
        NSLog(@"登录成功");
        [self performSegueWithIdentifier:@"loginToMain" sender:self];
    }
}


@end
