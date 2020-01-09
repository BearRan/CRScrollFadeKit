//
//  CRScrollFadeConfig.m
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import "CRScrollFadeConfig.h"

@interface CRScrollFadeConfig ()

@property(nonatomic, assign, readwrite) CGFloat fadeValue;

@end

@implementation CRScrollFadeConfig

+ (CRScrollFadeConfig *)defaultConfig
{
    return [CRScrollFadeConfig new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fadeDirection = CRScrollFadeDirection_Vert;
        self.fadeStartValue = @0;
        self.fadeEndValue = @100;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

#pragma mark - Setter
- (void)updateFadeValue:(CGFloat)fadeValue
{
    _fadeValue = fadeValue;
    if (self.fadeValueChangedBlock) {
        self.fadeValueChangedBlock(fadeValue);
    }
}
@end