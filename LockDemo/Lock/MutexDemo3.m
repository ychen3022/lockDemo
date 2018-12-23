//
//  MutexDemo3.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/19.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "MutexDemo3.h"
#import <pthread.h>

@interface MutexDemo3 ()

@property (assign, nonatomic) pthread_mutex_t mutex;//锁
@property (assign,nonatomic)pthread_cond_t cond;//条件
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation MutexDemo3

- (instancetype)init{
    self = [super init];
    if (self) {
        // 初始化属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);
        //初始化锁
        pthread_mutex_init(&_mutex, &attr);
        //销毁属性
        pthread_mutexattr_destroy(&attr);
        //初始化条件
        pthread_cond_init(&_cond, NULL);
        
        self.data = [NSMutableArray array];
    }
    return self;
}

//在多个线程之间存在依赖关系时候，我们常用到这种条件锁，例如生产者-消费者模式
//remove操作必须依赖add操作，当数组中有东西时（count>0）,才能够进行remove操作
//pthread_cond_signal和pthread_cond_broadcast分别对应一个线程监听（信号）和多个线程监听（广播）
- (void)condTest{
    [[[NSThread alloc] initWithTarget:self selector:@selector(remove) object:nil] start];//线程A
    [[[NSThread alloc] initWithTarget:self selector:@selector(add) object:nil] start];//线程B
}

//在线程A中:删除数组中的元素
- (void)remove{
    pthread_mutex_lock(&_mutex);
    NSLog(@"remove - begin");
    if (self.data.count == 0) {
        //当数组中没有数据时，进入休眠，并且放开这把锁
        //等到接受信号后，被唤醒，会再次对这把锁加锁
        // _cond是条件，进入休眠和唤醒，都是以该条件作为判断的，条件一致，才会操作
        pthread_cond_wait(&_cond, &_mutex);
    }
    [self.data removeLastObject];
    NSLog(@"remove - finish %@",[NSThread currentThread]);
    pthread_mutex_unlock(&_mutex);
}

// 在线程B中:往数组中添加元素
- (void)add{
    pthread_mutex_lock(&_mutex);
    sleep(1);
    [self.data addObject:@"Test"];
    NSLog(@"add - finish %@",[NSThread currentThread]);
    
    //信号:唤醒一个在等待这个条件的线程线程
    pthread_cond_signal(&_cond);
    
    //广播：唤醒所有在等待这个条件的线程
    //    pthread_cond_broadcast(&_cond);
    
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc{
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_cond);
}


@end
