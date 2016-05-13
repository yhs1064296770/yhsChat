//
//  UserInfo.h
//  yhsChat
//
//  Created by 姚海深 on 16/5/13.
//  Copyright © 2016年 姚海深. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "Singleton.h"

@interface UserInfo : NSObject
singleton_interface(UserInfo)

@property (nonatomic ,strong)NSString *userName;
@property (nonatomic ,strong)NSString *password;
@property(nonatomic,strong) FMDatabase *db;


@end
