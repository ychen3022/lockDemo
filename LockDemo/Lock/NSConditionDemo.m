//
//  NSConditionDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/22.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo ()

@property (strong, nonatomic) NSCondition *condition;//条件和锁封装到一起
@property (strong, nonatomic) NSMutableArray *data;
@end


//NSCondition是对mutex和cond的封装
@implementation NSConditionDemo

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化
        self.condition = [[NSCondition alloc] init];
        
        self.data = [NSMutableArray array];
    }
    return self;
}


//在多个线程之间存在依赖关系时候，我们常用到这种条件锁，例如生产者-消费者模式
//remove操作必须依赖add操作，当数组中有东西时（count>0）,才能够进行remove操作
//signal和broadcast分别对应一个线程监听（信号）和多个线程监听（广播）
- (void)condTest{
    [[[NSThread alloc] initWithTarget:self selector:@selector(remove) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(add) object:nil] start];
}

//在线程A中:删除数组中的元素
- (void)remove{
    [self.condition lock];
    NSLog(@"remove - begin");
    if (self.data.count == 0) {
        //当数组中没有数据时，进入休眠，并且放开这把锁
        //等到接受信号后，被唤醒，会再次对这把锁加锁
        [self.condition wait];
    }
    [self.data removeLastObject];
    NSLog(@"remove - finish %@",[NSThread currentThread]);
    [self.condition unlock];
}

// 在线程B中:往数组中添加元素
- (void)add{
    [self.condition lock];
    sleep(1);
    [self.data addObject:@"Test"];
    NSLog(@"add - finish %@",[NSThread currentThread]);
    
    //信号:唤醒一个在等待这个条件的线程线程
    [self.condition signal];
    
    //广播：唤醒所有在等待这个条件的线程
    //[self.condition broadcast];
    [self.condition unlock];
}
@end
