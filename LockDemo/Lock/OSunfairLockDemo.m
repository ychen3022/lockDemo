//
//  OSunfairLockDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/19.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "OSunfairLockDemo.h"
#import <OS/lock.h>

//os_unfair_lock  低级锁：会休眠
@interface OSunfairLockDemo ()

@property(nonatomic,assign)os_unfair_lock moneyLock;
@property(nonatomic,assign)os_unfair_lock ticketLock;
@end

@implementation OSunfairLockDemo

- (instancetype)init{
    self = [super init];
    if (self) {
        _moneyLock = OS_UNFAIR_LOCK_INIT;
        _ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

//取钱操作
- (void)drawMoney{
    os_unfair_lock_lock(&_moneyLock);
    [super drawMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

//存钱操作
- (void)saveMoney{
    os_unfair_lock_lock(&_moneyLock);
    [super saveMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

//卖票操作
- (void)saleTicket{
    os_unfair_lock_lock(&_ticketLock);
    [super saleTicket];
    os_unfair_lock_unlock(&_ticketLock);
}
@end


