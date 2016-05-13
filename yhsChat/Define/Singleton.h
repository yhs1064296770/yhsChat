//
//  Singleton.h
//  帮帮零时工
//
//  Created by 姚海深 on 15/12/30.
//  Copyright © 2015年 姚海深. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

//.h
#define singleton_interface(class) + (instancetype)shared##class;

//.m
#define singleton_implementation(class) \
static class *_instance;\
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
\
    return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
    if (_instance == nil){ \
        _instance = [[class alloc] init]; \
    } \
\
    return _instance; \
} \

#endif /* Singleton_h */
