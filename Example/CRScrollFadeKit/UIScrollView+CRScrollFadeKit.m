//
//  UIScrollView+CRScrollFadeKit.m
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import "UIScrollView+CRScrollFadeKit.h"
#import "CRScrollFadeConfig.h"
#import <objc/runtime.h>

@interface UIScrollView (CRScrollFadeKit_Private)

@property(nonatomic, strong) NSMutableArray <CRScrollFadeConfig *> *crScrollFade_configArray;

@end

@implementation UIScrollView (CRScrollFadeKit)

// 方法交换
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        crScrollFade_swizzled_method(class,
                                     @selector(willMoveToSuperview:),
                                     @selector(crScrollFade_willMoveToSuperview:));
    });
}

- (void)crScrollFade_willMoveToSuperview:(UIView *)newSuperview {
    // 移除旧的监听
    [self crScrollFade_removeObservers];
    
    // 有新的父组件，则添加新的监听
    if (newSuperview) {
        [self crScrollFade_addObservers];
    }
    
    [self crScrollFade_willMoveToSuperview:newSuperview];
}


#pragma mark - Observer
- (void)crScrollFade_addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:CRScrollFadeKeyPath_ContentOffSet options:options context:nil];
}

- (void)crScrollFade_removeObservers {
    [self removeObserver:self forKeyPath:CRScrollFadeKeyPath_ContentOffSet];
}

#pragma mark - Param
- (NSMutableArray <CRScrollFadeConfig *> *)crScrollFade_configArray {
    NSMutableArray *tempConfigArray = objc_getAssociatedObject(self, _cmd);
    if (!tempConfigArray) {
        tempConfigArray = [NSMutableArray new];
        self.crScrollFade_configArray = tempConfigArray;
    }
    
    return tempConfigArray;
}

- (void)setCrScrollFade_configArray:(NSMutableArray<CRScrollFadeConfig *> *)crScrollFade_configArray {
    objc_setAssociatedObject(self, @selector(crScrollFade_configArray), crScrollFade_configArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Process Config
- (void)crScrollFade_addScrollFadeConfig:(CRScrollFadeConfig *)scrollFadeConfig {
    if (scrollFadeConfig && [scrollFadeConfig isKindOfClass:[CRScrollFadeConfig class]]) {
        [self.crScrollFade_configArray addObject:scrollFadeConfig];
    }
}

- (void)crScrollFade_removeScrollFadeConfig:(CRScrollFadeConfig *)scrollFadeConfig {
    if (scrollFadeConfig && [scrollFadeConfig isKindOfClass:[CRScrollFadeConfig class]]) {
        if ([self.crScrollFade_configArray containsObject:scrollFadeConfig]) {
            [self.crScrollFade_configArray removeObject:scrollFadeConfig];
        }
    }
}

- (NSArray <CRScrollFadeConfig *> *)crScrollFade_getAllConfigArray {
    return [self.crScrollFade_configArray copy];
}

#pragma mark - Swizzled
// 使用static inline创建静态内联函数，方便调用
static inline void crScrollFade_swizzled_method(Class cls ,SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL isAdd = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAdd) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
