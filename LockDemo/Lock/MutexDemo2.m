//
//  MutexDemo2.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/19.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "MutexDemo2.h"
#import <pthread.h>

//pthread_mutex_t的另一种用法，就是递归锁，其实递归锁只是互斥锁的一个特例
//递归锁：同一时刻只能有一个线程访问对象，但允许同一个线程在未释放其拥有的锁时反复对该锁进行加锁操作
@interface MutexDemo2 ()

@property(nonatomic,assign)pthread_mutex_t mutex;
@end

@implementation MutexDemo2
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initMutex:&(_mutex)];
    }
    return self;
}

-(void)initMutex:(pthread_mutex_t *)mutex{
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);//修改属性为递归锁
    // 初始化锁
    pthread_mutex_init(mutex, &attr);
    //销毁属性
    pthread_mutexattr_destroy(&attr);
    //销毁锁
    //pthread_mutex_destroy(mutex);
}

//递归锁测试
//在这个例子中，如果在递归情况下用的PTHREAD_MUTEX_DEFAULT属性，会导致进程卡住，任务无法执行
-(void)recursiveTest{
    pthread_mutex_lock(&_mutex);
    
    static int count = 0;
    count++;
    NSLog(@"%s", __func__);
    
    if (count < 10) {
        [self recursiveTest];
    }
    pthread_mutex_unlock(&_mutex);
}

-(void)dealloc{
    pthread_mutex_destroy(&_mutex);
}
@end
