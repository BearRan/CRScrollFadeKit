//
//  CRViewController.m
//  CRScrollFadeKit
//
//  Created by BearRan on 01/09/2020.
//  Copyright (c) 2020 BearRan. All rights reserved.
//

#import "CRViewController.h"

@interface CRViewController ()

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTestBtn];
}

- (void)addTestBtn
{
    UIButton *testBtn = [[UIButton alloc] init];
    testBtn.backgroundColor = [UIColor orangeColor];
    [testBtn setTitle:@"Test" forState:UIControlStateNormal];
    [self.view addSubview:testBtn];
    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@200);
        make.centerX.centerY.equalTo(@0);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
