//
//  CRListTestVC.m
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import "CRListTestVC.h"
#import "CRTestScrollView.h"

@interface CRListTestVC ()

@property(nonatomic, strong) CRTestScrollView *mainScrollView;

@end

@implementation CRListTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CRListTestVC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mainScrollView = [CRTestScrollView new];
    self.mainScrollView.backgroundColor = [UIColor orangeColor];
    self.mainScrollView.contentSize = CGSizeMake(1000, 1000);
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@(UIEdgeInsetsZero));
    }];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(300, 300, 100, 100)];
    testView.backgroundColor = [UIColor blueColor];
    [self.mainScrollView addSubview:testView];
}


@end
