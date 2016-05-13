//
//  ApplyFriendViewController.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/13.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "ApplyFriendViewController.h"
#import "ApplyFriend.h"
#import "UserInfo.h"
#import "EMSDK.h"

@interface ApplyFriendViewController()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ApplyFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

#pragma mark --  UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.applyFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ApplyFriend *friend = self.applyFriends[indexPath.row];
    cell.textLabel.text = friend.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyFriend *friend = self.applyFriends[indexPath.row];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@想要和你做朋友",friend.name] message:friend.message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:friend.name];
        if (!error) {
            NSLog(@"发送同意成功");
            BOOL delete = [[UserInfo sharedUserInfo].db executeUpdate:@"delete from t_friend_apply where name like ?",friend.name];
            if (delete) {
                NSLog(@"删除数据成功");
            }else{
                NSLog(@"删除数据失败");
            }
            BOOL insert = [[UserInfo sharedUserInfo].db executeUpdate:@"insert into t_friend (name) values(?)",friend.name];
            if (insert) {
                NSLog(@"插入数据成功");
            }else{
                NSLog(@"插入数据失败");
            }
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:friend.name];
        if (!error) {
            NSLog(@"发送拒绝成功");
            BOOL delete = [[UserInfo sharedUserInfo].db executeUpdate:@"delete from t_friend_apply where name like ?",friend.name];
            if (delete) {
                NSLog(@"删除数据成功");
            }else{
                NSLog(@"删除数据失败");
            }
        }
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
