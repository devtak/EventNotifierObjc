//
//  EventNotifier.m
//  ObserverSample
//
//  Created by devtak on 2017. 5. 28..
//  Copyright (c) 2017 devtak. All rights reserved.
//

#import "EventNotifier.h"
#import <objc/message.h>


@interface EventNotifier ()

@property (atomic, readwrite) NSPointerArray *observers;

@end


@implementation EventNotifier

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.observers = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];
    }
    
    return self;
}

- (void)addEventObserver:(id)observer
{
    if (!observer)
    {
        return;
    }
    
    for (int i = 0; i < self.observers.count; ++i)
    {
        void *p = [self.observers pointerAtIndex:i];
        if (p == (__bridge void * _Nullable)(observer))
        {
            return;
        }
    }
    
    [self.observers addPointer:(__bridge void * _Nullable)(observer)];
}

- (void)removeEventObserver:(id)observer
{
    if (!observer)
    {
        return;
    }
    
    for (NSInteger i = self.observers.count - 1; i >= 0; --i)
    {
        void *p = [self.observers pointerAtIndex:i];
        void *p2 = (__bridge void * _Nullable)(observer);
        if (p == p2)
        {
            [self.observers removePointerAtIndex:i];
            break;
        }
        
        if (!p)
        {
            [self.observers removePointerAtIndex:i];
        }
    }
}

- (void)removeAllObserver
{
    while (self.observers.count)
    {
        [self.observers removePointerAtIndex:0];
    }
}

- (void)fireEvent:(SEL)selector, ...
{
    if (0 == [self.observers count])
    {
        return;
    }
    
    va_list sArgs;
    va_start(sArgs, selector);
    
    NSMethodSignature *signature;
    NSInvocation      *invocation;
    NSPointerArray *copyObservers = [self.observers copy];
    
    for (int i = 0; i < copyObservers.count; ++i)
    {
        id observer = (__bridge id)([copyObservers pointerAtIndex:i]);
        if (!observer)
        {
            continue;
        }
        
        signature = [observer methodSignatureForSelector:selector];
        if (!signature)
        {
            continue;
        }
        
        invocation = [NSInvocation invocationWithMethodSignature:signature];
        if (invocation)
        {
            break;
        }
    }
    
    if (!invocation)
    {
        return;
    }
    
    [invocation setSelector:selector];
    
    NSUInteger arg_count = [signature numberOfArguments];
    for (NSInteger i = 0; i < arg_count - 2; ++i)
    {
        id arg = va_arg(sArgs, id);
        [invocation setArgument:&arg atIndex: 2 + i];
    }
    
    for (int i = 0; i < copyObservers.count; ++i)
    {
        id observer = (__bridge id)([copyObservers pointerAtIndex:i]);
        if (observer && [observer respondsToSelector:selector])
        {
            [invocation setTarget:observer];
            [invocation invoke];
        }
    }
    va_end(sArgs);
}


@end
