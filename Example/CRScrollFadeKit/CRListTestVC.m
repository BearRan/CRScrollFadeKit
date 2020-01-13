//
//  CRListTestVC.m
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import "CRListTestVC.h"
#import "CRTestScrollView.h"
#import "UIScrollView+CRScrollFadeKit.h"

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
    self.mainScrollView.contentSize = CGSizeMake(10000, 10000);
    self.mainScrollView.pagingEnabled = YES;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@(UIEdgeInsetsZero));
    }];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(300, 300, 100, 100)];
    testView.backgroundColor = [UIColor blueColor];
    [self.mainScrollView addSubview:testView];
    
    CRScrollFadeListener *fadeListenerVert = [CRScrollFadeListener defaultConfig];
    fadeListenerVert.pagingEnabled = YES;
    fadeListenerVert.fadeValueChangedBlock = ^(CGFloat fadeValue, NSInteger page) {
        NSLog(@"--fadeListener-Vert:%f, page:%ld", fadeValue, (long)page);
    };
    [self.mainScrollView cr_addScrollFadeListener:fadeListenerVert];
    
    CRScrollFadeListener *fadeListenerHorz = [CRScrollFadeListener defaultConfig];
    fadeListenerHorz.fadeDirection = CRScrollFadeDirection_Horz;
    fadeListenerHorz.fadeValueChangedBlock = ^(CGFloat fadeValue, NSInteger page) {
        NSLog(@"--fadeListener-Horz:%f, page:%ld", fadeValue, (long)page);
    };
    [self.mainScrollView cr_addScrollFadeListener:fadeListenerHorz];
}


@end
