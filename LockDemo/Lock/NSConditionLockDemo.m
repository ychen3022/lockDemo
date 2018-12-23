//
//  NSConditionLockDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/22.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo ()

@property (strong, nonatomic) NSConditionLock *conditionLock;
@end

//NSConditionLock是对NSCondition的进一步封装，可以设置具体的条件值
@implementation NSConditionLockDemo

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化，且设置条件值为1
        self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];
    }
    return self;
}

//设置三条线程
//通过NSConditionLock达到先执行one、再执行three、再执行two
//有一个依赖的关系
-(void)dependTest{
    [[[NSThread alloc] initWithTarget:self selector:@selector(three) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(two) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(one) object:nil] start];
}


-(void)one{
    //没有设置条件，直接加锁
    [self.conditionLock lock];
    NSLog(@"___one");
    //通过条件值2 放开这把锁
    [self.conditionLock unlockWithCondition:2];
}

-(void)two{
    //满足条件值为3的时候，加锁
    [self.conditionLock lockWhenCondition:3];
    NSLog(@"___two");
    //放开这把锁
    [self.conditionLock unlock];
}

-(void)three{
    //满足条件值为2的时候，加锁
    [self.conditionLock lockWhenCondition:2];
    NSLog(@"___three");
    //通过条件值3 放开这把锁
    [self.conditionLock unlockWithCondition:3];
}
@end
