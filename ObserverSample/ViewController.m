//
//  ViewController.m
//  ObserverSample
//
//  Created by yunhyotak on 2017. 5. 28..
//  Copyright © 2017년 devtak. All rights reserved.
//

#import "ViewController.h"
#import "Observer.h"
#import "Subject.h"


@interface ViewController ()

@property (nonatomic) Observer *observer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.observer = [Observer new];
    [Subject.sharedInstance Foo:@"test_param"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
