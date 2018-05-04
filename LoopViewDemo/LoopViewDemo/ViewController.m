//
//  ViewController.m
//  LoopViewDemo
//
//  Created by xuzhichao on 2018/5/4.
//  Copyright © 2018年 xuzhichao. All rights reserved.
//

#import "ViewController.h"
#import "LoopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoopView *loopView = [LoopView loopViewWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    loopView.imageArray = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    [self.view addSubview:loopView];
    
}

@end
