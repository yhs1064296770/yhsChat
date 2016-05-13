//
//  GroupViewController.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/11.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupView.h"
#import "EMSDK.h"

@interface GroupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSArray *userlist;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    self.tableView.tableHeaderView = [[GroupView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70) clickHandler:^(NSInteger num) {
        NSLog(@"111");
    }];
    self.userlist = [NSArray arrayWithArray:[[EMClient sharedClient].contactManager getContactsFromServerWithError:nil]];
    NSArray *userlist1 = [[EMClient sharedClient].contactManager getContactsFromDB];
    NSLog(@"%@",userlist1);
    [self setNavigation:@"群组" rightButton:@"➕" andNeedLeftButton:NO];
    // Do any additional setup after loading the view.
}

- (void)rightClick:(UIButton *)button{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加好友" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"好友帐号";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"验证信息";
        textField.secureTextEntry = YES;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *friendTeXT = alertController.textFields.firstObject;
        UITextField *message = alertController.textFields.lastObject;
        EMError *error = [[EMClient sharedClient].contactManager addContact:friendTeXT.text message:message.text];
        if (!error) {
            NSLog(@"添加成功");
        }
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{
    
}

#pragma mark --  UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}


@end
