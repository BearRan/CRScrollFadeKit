//
//  CRViewController.m
//  CRScrollFadeKit
//
//  Created by BearRan on 01/09/2020.
//  Copyright (c) 2020 BearRan. All rights reserved.
//

#import "CRViewController.h"
#import "CRListTestVC.h"

@interface CRViewController ()

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self addTestBtn];
}

- (void)addTestBtn
{
    UIButton *testBtn = [[UIButton alloc] init];
    [testBtn addTarget:self action:@selector(pushToListTestVC) forControlEvents:UIControlEventTouchUpInside];
    testBtn.backgroundColor = [UIColor orangeColor];
    [testBtn setTitle:@"Test" forState:UIControlStateNormal];
    [self.view addSubview:testBtn];
    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@200);
        make.centerX.centerY.equalTo(@0);
    }];
}

- (void)pushToListTestVC {
    CRListTestVC *listTestVC = [CRListTestVC new];
    [self.navigationController pushViewController:listTestVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
