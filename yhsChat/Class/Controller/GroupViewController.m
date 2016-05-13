//
//  GroupViewController.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/11.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "GroupViewController.h"
#import "ApplyFriendViewController.h"
#import "ChatViewController.h"
#import "ApplyFriend.h"
#import "GroupView.h"
#import "UserInfo.h"
#import "EMSDK.h"

@interface GroupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSArray *userlist;
@property (nonatomic ,strong)NSArray *applyFriend;
@property (nonatomic ,strong)NSString *friendName;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册好友回调
    
    self.tableView.tableHeaderView = [[GroupView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70) clickHandler:^(NSInteger num) {
        NSLog(@"111");
    }];
//    self.userlist = [NSArray arrayWithArray:[[EMClient sharedClient].contactManager getContactsFromServerWithError:nil]];
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
    NSLog(@"%@,%@",aUsername,aMessage);
    
    [[EMClient sharedClient].contactManager removeDelegate:self];
}

#pragma mark --  UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.applyFriend.count;
    }
    if (section == 1) {
        return self.userlist.count;
    }
    return self.userlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        ApplyFriend *friend = [ApplyFriend new];
        friend = self.applyFriend[indexPath.row];
        cell.textLabel.text = friend.name;
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = self.userlist[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"applyFriend" sender:self];
    }
    
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"groupToChat" sender:self];
        self.friendName =self.userlist[indexPath.row];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // segue.identifier：获取连线的ID
    if ([segue.identifier isEqualToString:@"applyFriend"]) {
        // segue.destinationViewController：获取连线时所指的界面（VC）
        ApplyFriendViewController *receive = segue.destinationViewController;
        receive.applyFriends = self.applyFriend;
        // 这里不需要指定跳转了，因为在按扭的事件里已经有跳转的代码
        //		[self.navigationController pushViewController:receive animated:YES];
    }
    if ([segue.identifier isEqualToString:@"groupToChat"]) {
        ChatViewController *receive = segue.destinationViewController;
        receive.titleName = self.friendName;
    }
}

- (NSArray *)applyFriend {
	if(_applyFriend == nil) {
        FMResultSet *set = [[UserInfo sharedUserInfo].db executeQuery:@"select * from t_friend_apply "];
        NSMutableArray *mutArr = [NSMutableArray array];
        while ([set next]) {
            ApplyFriend *friend = [ApplyFriend new];
            NSString *name =  [set stringForColumn:@"name"];
            NSString *message = [set stringForColumn:@"message"];
            NSLog(@"name : %@ message: %@",name,message);
            friend.name = name;
            friend.message = message;
            [mutArr addObject:friend];
        }
		_applyFriend = [mutArr copy];
	}
	return _applyFriend;
}

- (NSArray *)userlist {
	if(_userlist == nil) {
        FMResultSet *set = [[UserInfo sharedUserInfo].db executeQuery:@"select * from t_friend"];
        NSMutableArray *mutArr = [NSMutableArray array];
        while ([set next]) {
            NSString *name =  [set stringForColumn:@"name"];
            [mutArr addObject:name];
        }
        _userlist = [mutArr copy];
	}
	return _userlist;
}

@end
