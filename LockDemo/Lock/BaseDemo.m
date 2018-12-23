//
//  BaseDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/19.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "BaseDemo.h"

@interface BaseDemo ()

@property(nonatomic,assign)int money;
@property(nonatomic,assign)int ticketCount;
@end

@implementation BaseDemo

#pragma mark -存钱取钱案例
-(void)moneyTest{
    self.money = 100;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i<10; i++) {
            [self saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<10; i++) {
            [self drawMoney];
        }
    });
}

//存钱操作
-(void)saveMoney{
    int oldMoney = self.money;
    sleep(.2);
    oldMoney +=50;
    self.money=oldMoney;
    NSLog(@"存50，还剩%d元 ---%@",oldMoney,[NSThread currentThread]);
}

//取钱操作
-(void)drawMoney{
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -=20;
    self.money = oldMoney;
    NSLog(@"取20，还剩%d元---%@",self.money,[NSThread currentThread]);
}



#pragma mark -卖票案例
-(void)ticketTest{
    self.ticketCount = 15;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
}

//卖票操作
-(void)saleTicket{
    int oldTicketsCount = self.ticketCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketCount = oldTicketsCount;
    NSLog(@"还剩%d张票 - %@", oldTicketsCount, [NSThread currentThread]);
}


#pragma 递归锁案例
-(void)recursiveTest{
    
}

#pragma mark -锁的条件案例
-(void)condTest{
    
}

#pragma mark -NSConditionLock的依赖案例
-(void)dependTest{
    
}

#pragma mark -dispatch_semaphore_t的最大并发案例
-(void)semaphoreTest{
    
}
@end
