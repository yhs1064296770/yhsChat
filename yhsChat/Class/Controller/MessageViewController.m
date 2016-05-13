//
//  MessageViewController.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/11.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "MessageViewController.h"
#import "ChatViewController.h"
#import "EMSDK.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong)NSArray *conversations;

@property (nonatomic,strong)NSString *applyFriend;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.conversations = [NSArray arrayWithArray:[[EMClient sharedClient].chatManager getAllConversations]];
    self.conversations = [[EMClient sharedClient].chatManager getAllConversations];
    // Do any additional setup after loading the view.
}

#pragma mark --  UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    EMConversation *conversation = self.conversations[indexPath.row];
    cell.textLabel.text = conversation.conversationId;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"MessageToChat" sender:self];
    EMConversation *conversation = self.conversations[indexPath.row];
    self.applyFriend = conversation.conversationId;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MessageToChat"]) {
        ChatViewController *receive = segue.destinationViewController;
        receive.titleName = self.applyFriend;
    }
}


@end
