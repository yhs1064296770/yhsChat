//
//  UserInfo.m
//  yhsChat
//
//  Created by 姚海深 on 16/5/13.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo
singleton_implementation(UserInfo)

- (FMDatabase *)db {
    if(_db == nil) {
        //数据的路径，放在沙盒的cache下面
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath = [cacheDir stringByAppendingPathComponent:@"contact.sqlite"];
        
        //创建并且打开一个数据库
        _db = [FMDatabase databaseWithPath:filePath];
        
        BOOL flag = [_db open];
        if (flag) {
            NSLog(@"数据库打开成功");
        }else{
            NSLog(@"数据库打开失败");
        }
        //创建好友申请表
        BOOL create =  [_db executeUpdate:@"create table if not exists t_friend_apply(id integer primary key  autoincrement, name text,message text)"];
        
        if (create) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }
        //创建好友申请表
        BOOL createFriend =  [_db executeUpdate:@"create table if not exists t_friend(id integer primary key  autoincrement, name text)"];
        
        if (createFriend) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }

    }
    return _db;
}

@end
