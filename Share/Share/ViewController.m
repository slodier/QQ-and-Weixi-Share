//
//  ViewController.m
//  Share
//
//  Created by CC on 2016/11/19.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "ViewController.h"
#import "ShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShareView *shareView = [[ShareView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:shareView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
