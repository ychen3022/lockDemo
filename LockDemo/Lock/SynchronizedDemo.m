//
//  SynchronizedDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/22.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "SynchronizedDemo.h"

@interface SynchronizedDemo ()

@end

//不同事件中，@synchronized()中的内容不能一样
@implementation SynchronizedDemo

//取钱操作
- (void)drawMoney{
    @synchronized (self) {
        [super drawMoney];
    }
}

//存钱操作
- (void)saveMoney{
    @synchronized (self) {
        [super saveMoney];
    }
}

//卖票操作
- (void)saleTicket{
    static NSObject *lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [[NSObject alloc] init];
    });
    @synchronized (lock) {
        [super saleTicket];
    }
}

//递归锁测试
//递归操作中，可以执行10次，不会被卡住
-(void)recursiveTest{
    static NSObject *lock1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock1 = [[NSObject alloc] init];
    });
    @synchronized (lock1) {
        static int count = 0;
        count++;
        NSLog(@"执行递归操作 %s", __func__);
        if (count < 10) {
            [self recursiveTest];
        }
    }
}
@end

