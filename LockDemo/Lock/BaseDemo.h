//
//  BaseDemo.h
//  LockDemo
//
//  Created by 陈园 on 2018/12/19.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDemo : NSObject

#pragma mark -存钱取钱案例
-(void)moneyTest;

#pragma mark -卖票案例
-(void)ticketTest;

#pragma 锁的递归锁案例
-(void)recursiveTest;

#pragma mark -锁的条件案例
-(void)condTest;

#pragma mark -NSConditionLock的依赖案例
-(void)dependTest;

#pragma mark -dispatch_semaphore_t的最大并发案例
-(void)semaphoreTest;

-(void)saveMoney;
-(void)drawMoney;
-(void)saleTicket;
@end

NS_ASSUME_NONNULL_END
