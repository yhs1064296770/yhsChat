//
//  ChatViewController.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/13.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "ChatViewController.h"
#import "EMSDK.h"

@interface ChatViewController()<UITableViewDataSource,UITableViewDelegate,EMChatManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic ,strong)EMConversation *conversation;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = self.titleName;
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    self.conversation = [[EMClient sharedClient].chatManager getConversation:self.titleName type:EMConversationTypeChat createIfNotExist:YES];
    // Do any additional setup after loading the view.
}
- (IBAction)imput:(id)sender {
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:self.textField.text];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:self.titleName from:from to:self.titleName body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    
     [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
         
     } completion:^(EMMessage *message, EMError *error) {
         
     }];
    
}

- (void)didReceiveMessages:(NSArray *)aMessages{
    NSLog(@"%@",aMessages);
}

- (void)didReceiveCmdMessages:(NSArray *)aCmdMessages{
    NSLog(@"%@",aCmdMessages);
}

#pragma mark --  UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}


@end
