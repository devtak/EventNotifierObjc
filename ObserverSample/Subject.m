//
//  Subject.m
//  ObserverSample
//
//  Created by yunhyotak on 2017. 5. 28..
//  Copyright © 2017년 devtak. All rights reserved.
//

#import "Subject.h"

@implementation Subject

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static Subject *instance = nil;
    
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)Foo:(NSString *)param
{
    [self fireEvent:@selector(onSubjectEventFoo:), param];
}


@end
