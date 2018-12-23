//
//  MutexDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/19.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "MutexDemo.h"
#import <pthread.h>

//pthread_mutex_t  低级锁：会休眠
@interface MutexDemo ()

@property(nonatomic,assign)pthread_mutex_t moenyMutex;
@property(nonatomic,assign)pthread_mutex_t ticketMutex;
@end

@implementation MutexDemo

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initMutex:&(_moenyMutex)];
        [self initMutex:&(_ticketMutex)];
    }
    return self;
}

- (void)initMutex:(pthread_mutex_t *)mutex{
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    //pthread_mutex_init(mutex, &attr);
    pthread_mutex_init(mutex, NULL);//属性设置为null也是可以的，这个时候的锁也是默认的锁
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    // 销毁锁
    //pthread_mutex_destroy(mutex);
}

//取钱操作
- (void)drawMoney{
    pthread_mutex_lock(&_moenyMutex);
    [super drawMoney];
    pthread_mutex_unlock(&_moenyMutex);
}

//存钱操作
- (void)saveMoney{
    pthread_mutex_lock(&_moenyMutex);
    [super saveMoney];
    pthread_mutex_unlock(&_moenyMutex);
}

//卖票操作
- (void)saleTicket{
    pthread_mutex_lock(&_ticketMutex);
    [super saleTicket];
    pthread_mutex_unlock(&_ticketMutex);
}

- (void)dealloc{
    pthread_mutex_destroy(&_moenyMutex);
    pthread_mutex_destroy(&_ticketMutex);
}

@end

