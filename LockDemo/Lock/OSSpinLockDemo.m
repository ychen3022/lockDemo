//
//  OSSpinLockDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/19.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>//需要导入头文件

//OSSpinLock 自旋锁（高级锁）：不会休眠
@interface OSSpinLockDemo()

@end



@implementation OSSpinLockDemo

static OSSpinLock moneyLock;
static OSSpinLock ticketLock;
+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        moneyLock = 0; //OS_SPINLOCK_INIT其实就是0,可见源码显示
        ticketLock = OS_SPINLOCK_INIT;
    });
}

//取钱操作
-(void)drawMoney{
    OSSpinLockLock(&moneyLock);
    [super drawMoney];
    OSSpinLockUnlock(&moneyLock);
}

//存钱操作
-(void)saveMoney{
    OSSpinLockLock(&moneyLock);
    [super saveMoney];
    OSSpinLockUnlock(&moneyLock);
}

//卖票操作
- (void)saleTicket{
    OSSpinLockLock(&ticketLock);
    [super saleTicket];
    OSSpinLockUnlock(&ticketLock);
}
@end

