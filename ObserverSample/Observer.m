//
//  Observer.m
//  ObserverSample
//
//  Created by yunhyotak on 2017. 5. 28..
//  Copyright © 2017년 devtak. All rights reserved.
//

#import "Observer.h"
#import "Subject.h"


@interface Observer () <SubjectEventListener>

@end

@implementation Observer

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [Subject.sharedInstance addEventObserver:self];
    }
    return self;
}

- (void)dealloc
{
    [Subject.sharedInstance removeEventObserver:self];
}

- (void)onSubjectEventFoo:(NSString *)param
{
    NSLog(@"%@", param);
}

@end
