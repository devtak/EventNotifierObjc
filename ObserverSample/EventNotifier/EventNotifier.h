//
//  EventNotifier.h
//  ObserverSample
//
//  Created by devtak on 2017. 5. 28..
//  Copyright (c) 2017 devtak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventNotifier<ListenerType> : NSObject

@property (atomic, readonly) NSPointerArray *observers;

- (void)addEventObserver:(__weak ListenerType)observer;
- (void)removeEventObserver:(__weak ListenerType)observer;
- (void)removeAllObserver;
- (void)fireEvent:(SEL)selector, ...;

@end
