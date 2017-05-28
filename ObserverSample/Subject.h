//
//  Subject.h
//  ObserverSample
//
//  Created by yunhyotak on 2017. 5. 28..
//  Copyright © 2017년 devtak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventNotifier.h"


@protocol SubjectEventListener <NSObject>

@optional

- (void)onSubjectEventFoo:(NSString *)param;

@end


@interface Subject : EventNotifier<id<SubjectEventListener>>

+ (instancetype)sharedInstance;
- (void)Foo:(NSString *)param;

@end
