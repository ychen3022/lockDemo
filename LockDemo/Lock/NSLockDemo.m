//
//  NSLockDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/22.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()

@property(nonatomic,strong)NSLock *ticketLock;
@property(nonatomic,strong)NSLock *moneyLock;
@end


//NSLock是对mutex普通锁的封装
@implementation NSLockDemo

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化锁
        self.ticketLock = [[NSLock alloc] init];
        self.moneyLock = [[NSLock alloc] init];
    }
    return self;
}

//取钱操作
- (void)drawMoney{
    [self.moneyLock lock];
    [super drawMoney];
    [self.moneyLock unlock];
}

//存钱操作
- (void)saveMoney{
    [self.moneyLock lock];
    [super saveMoney];
    [self.moneyLock unlock];
}

//卖票操作
- (void)saleTicket{
    [self.ticketLock lock];
    [super saleTicket];
    [self.ticketLock unlock];
}



@end

