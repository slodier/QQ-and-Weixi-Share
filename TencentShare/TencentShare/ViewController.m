//
//  ViewController.m
//  TencentShare
//
//  Created by CC on 2017/3/22.
//  Copyright © 2017年 CC. All rights reserved.
//

#import "ViewController.h"
#import "ShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ShareView *shareView = [[ShareView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:shareView];
}

@end
