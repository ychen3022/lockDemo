//
//  SerialQueueDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/22.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "SerialQueueDemo.h"

@interface SerialQueueDemo ()

@property (strong, nonatomic) dispatch_queue_t ticketQueue;
@property (strong, nonatomic) dispatch_queue_t moneyQueue;
@end


//dispatch_queue  serial
//直接使用GCD的串行队列，也是可以实现线程同步的
//因为线程同步抢占一份资源的时候，也是一个一个按顺序执行的
@implementation SerialQueueDemo

- (instancetype)init{
    self = [super init];
    if (self) {
        self.ticketQueue = dispatch_queue_create("ticketQueue", DISPATCH_QUEUE_SERIAL);
        self.moneyQueue = dispatch_queue_create("moneyQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

//取钱操作
- (void)drawMoney{
    dispatch_sync(self.moneyQueue, ^{
        [super drawMoney];
    });
}

//存钱操作
- (void)saveMoney{
    dispatch_sync(self.moneyQueue, ^{
        [super saveMoney];
    });
}

//卖票操作
- (void)saleTicket{
    dispatch_sync(self.ticketQueue, ^{
        [super saleTicket];
    });
}

@end
