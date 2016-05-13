//
//  AppDelegate+HuanXin.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/13.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "AppDelegate+HuanXin.h"
#import "UserInfo.h"

@implementation AppDelegate (HuanXin)

- (void)userHuanXin{
    //AppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"yaohaishen#yhschat"];
    options.apnsCertName = @"YXA65K98kBgTEea9UA2i9_9s7g";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    UIStoryboard *secondStroyBoard=[UIStoryboard storyboardWithName:@"YhsChat" bundle:nil];
    UIViewController *login=[secondStroyBoard instantiateViewControllerWithIdentifier:@"Login"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController: login];
    [self.window makeKeyAndVisible];
    
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}

- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{
    NSLog(@"%@,%@",aUsername,aMessage);
    BOOL insert = [[UserInfo sharedUserInfo].db executeUpdate:@"insert into t_friend_apply (name,message) values(?,?)",aUsername,aMessage];
    if (insert) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername{
    
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
