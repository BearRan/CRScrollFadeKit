//
//  CRScrollFadeListener.m
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import "CRScrollFadeListener.h"

@interface CRScrollFadeListener () <CRScrollFadeProtocol>

@property(nonatomic, assign, readwrite, setter=updateFadeValue:) CGFloat fadeValue;

@end

@implementation CRScrollFadeListener

+ (CRScrollFadeListener *)defaultConfig
{
    return [CRScrollFadeListener new];
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

#pragma mark - CRScrollFadeProtocol
- (void)cr_scrollViewContentOffSetDidChange:(NSDictionary *)change {
    NSValue *oldValue = change[NSKeyValueChangeOldKey];
    NSValue *newValue = change[NSKeyValueChangeNewKey];
    
    CGFloat oldOffSet = 0;
    CGFloat newOffSet = 0;
    CGFloat contentInsetValue = 0;
    
    if (self.fadeDirection == CRScrollFadeDirection_Vert) {
        // 垂直方向
        oldOffSet = oldValue.UIOffsetValue.vertical;
        newOffSet = newValue.UIOffsetValue.vertical;
        contentInsetValue = self.contentInset.top;
    }else if (self.fadeDirection == CRScrollFadeDirection_Horz) {
        // 水平方向
        oldOffSet = oldValue.UIOffsetValue.horizontal;
        newOffSet = newValue.UIOffsetValue.horizontal;
        contentInsetValue = self.contentInset.left;
    }
    
    if (oldOffSet == newOffSet) {
        return;
    }
    
    NSAssert(self.fadeStartValue.floatValue < self.fadeEndValue.floatValue, @"fadeStartValue必须小于fadeEndValue");
    
    // 计算reaValue
    CGFloat resValue = 0;
    CGFloat fadeEndValue = self.fadeEndValue.floatValue;
    CGFloat fadeStartValue = self.fadeStartValue.floatValue;
    CGFloat offValue = newOffSet + contentInsetValue;
    if (offValue > fadeEndValue) {
        resValue = 1;
    }else if (offValue < fadeStartValue) {
        resValue = 0;
    }else{
        CGFloat deltaValue = fadeEndValue - fadeStartValue;
        resValue = 1.0 * (offValue - fadeStartValue) / deltaValue;
    }
    
    [self updateFadeValue:resValue];
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
