//
//  SemaphoreDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/22.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo ()

@property(nonatomic,strong)dispatch_semaphore_t semaphore;
@property(nonatomic,strong)dispatch_semaphore_t moneySemaphore;
@property(nonatomic,strong)dispatch_semaphore_t ticketSemaphore;
@end

@implementation SemaphoreDemo

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化信号量：dispatch_semaphore_create(X),X是最大并发数量
        self.semaphore = dispatch_semaphore_create(2);
        
        //设置存钱取钱案例的最大并发量为1，就可以保证只有一个线程对money进行修改
        self.moneySemaphore = dispatch_semaphore_create(1);
        
        //设置卖票案例的最大并发量为1，就可以保证只有一个线程对ticket进行修改
        self.ticketSemaphore = dispatch_semaphore_create(1);
    }
    return self;
}


//dispatch_semaphore_t的最大并发案例
-(void)semaphoreTest{
    for (int i=0; i<20; i++) {
        [[[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil] start];
    }
}

//控制线程的最大并发数量
-(void)test{
    // 如果信号量的值 > 0，就让信号量的值减1，然后继续往下执行代码
    // 如果信号量的值 <= 0，就会休眠等待，直到信号量的值变成>0，就让信号量的值减1，然后继续往下执行代码
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    sleep(1);
    NSLog(@"当前线程 %@",[NSThread currentThread]);
    
    // 让信号量的值+1
    dispatch_semaphore_signal(self.semaphore);
}

//取钱操作
- (void)drawMoney{
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    [super drawMoney];
    dispatch_semaphore_signal(self.moneySemaphore);
}

//存钱操作
- (void)saveMoney{
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    [super saveMoney];
    dispatch_semaphore_signal(self.moneySemaphore);
}

//卖票操作
- (void)saleTicket{
    dispatch_semaphore_wait(self.ticketSemaphore, DISPATCH_TIME_FOREVER);
    [super saleTicket];
    dispatch_semaphore_signal(self.ticketSemaphore);
}
@end




