//
//  NSRecursiveLockDemo.m
//  LockDemo
//
//  Created by 陈园 on 2018/12/22.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "NSRecursiveLockDemo.h"

@interface NSRecursiveLockDemo ()

@property(nonatomic,strong)NSRecursiveLock *recursiveLock;
@end

//NSRecursiveLock也是对mutex递归锁的封装，API跟NSLock基本一致
@implementation NSRecursiveLockDemo
- (instancetype)init{
    self = [super init];
    if (self) {
        self.recursiveLock = [[NSRecursiveLock alloc] init];
    }
    return self;
}


//递归锁测试
-(void)recursiveTest{
    [self.recursiveLock lock];
    static int count = 0;
    count++;
    NSLog(@"%s", __func__);
    
    if (count < 10) {
        [self recursiveTest];
    }
    [self.recursiveLock unlock];
}


@end
