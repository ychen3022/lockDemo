//
//  ViewController.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/19.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ViewController.h"
#import "BaseDemo.h"
#import "OSSpinLockDemo.h"
#import "OSunfairLockDemo.h"
#import "MutexDemo.h"
#import "MutexDemo2.h"
#import "MutexDemo3.h"
#import "NSLockDemo.h"
#import "NSRecursiveLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"
#import "SerialQueueDemo.h"
#import "SemaphoreDemo.h"
#import "SynchronizedDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //方案0:不加锁，会造成线程安全隐患
    /**
    BaseDemo *demo =  [[BaseDemo alloc] init];
    [demo moneyTest];
    [demo ticketTest];
    */

    //方案1:OSSpinLock，被弃用，会导致线程优先级反转问题，但是可以使用OSSpinLockTry来避免
    /**
     OSSpinLockDemo *demo1 = [[OSSpinLockDemo alloc] init];
     [demo1 moneyTest];
     [demo1 ticketTest];
     */
    
    //方案2:
    /**
    OSunfairLockDemo *demo2 = [[OSunfairLockDemo alloc] init];
    [demo2 moneyTest];
    [demo2 ticketTest];
    */
    
    //方案3:pthread_mutex_t的一般用法，设置属性PTHREAD_MUTEX_DEFAULT。
    /**
    MutexDemo *demo3 = [[MutexDemo alloc] init];
    [demo3 moneyTest];
    [demo3 ticketTest];
    */

    //方案4:pthread_mutex_t的递归，设置属性PTHREAD_MUTEX_RECURSIVE。
    // 如果在递归情况下用的PTHREAD_MUTEX_DEFAULT属性，会导致进程卡住，任务无法执行
    /**
    MutexDemo2 *demo4 = [[MutexDemo2 alloc] init];
    [demo4 recursiveTest];
    */
    
    //方案5:pthread_mutex_t的条件
    /**
    MutexDemo3 *demo5 = [[MutexDemo3 alloc] init];
    [demo5 condTest];
    */
    
    //方案6:NSLock    nslock是对mutex普通锁的封装
    /**
    NSLockDemo *demo6 = [[NSLockDemo alloc] init];
    [demo6 moneyTest];
    [demo6 ticketTest];
    */
    
    //方案7: NSRecursiveLock   NSRecursiveLock是对mutex的递归锁的封装
    /**
    NSRecursiveLockDemo *demo7 = [[NSRecursiveLockDemo alloc] init];
    [demo7 recursiveTest];
    */
    
    //方案8:NSCondition   NSCondition是对mutex和cond的封装
    /**
    NSConditionDemo *demo8 = [[NSConditionDemo alloc] init];
    [demo8 condTest];
    */
    
    //方案9:NSConditionLock
    /**
    NSConditionLockDemo *demo9 = [[NSConditionLockDemo alloc] init];
    [demo9 dependTest];
    */
    
    //方案10:dispatch_queue serial
    //直接使用GCD的串行队列，也是可以实现线程同步的
    /**
    SerialQueueDemo *demo10 = [[SerialQueueDemo alloc] init];
    [demo10 moneyTest];
    [demo10 ticketTest];
    */
    
    //方案11:dispatch_semaphore  可以设置最大并发数，当设置最大并发数为1的时候，就可以保证线程同步，从而达到线程安全
    /**
    SemaphoreDemo *demo11 = [[SemaphoreDemo alloc] init];
    [demo11 semaphoreTest];
    [demo11 moneyTest];
    [demo11 ticketTest];
    */
    
    //方案12:@synchronized
    
    SynchronizedDemo *demo12 = [[SynchronizedDemo alloc] init];
    [demo12 recursiveTest];
    [demo12 moneyTest];
    [demo12 ticketTest];
    
}


@end
