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

@interface UIScrollView (CRScrollFadeKit_Private) <CRScrollFadeProtocol>

@property(nonatomic, strong) NSMutableArray <CRScrollFadeConfig *> *cr_configArray;

@end

@implementation UIScrollView (CRScrollFadeKit)

#pragma mark - Swizzled
// 方法交换
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        cr_swizzled_method(class,
                           @selector(willMoveToSuperview:),
                           @selector(cr_willMoveToSuperview:));
        cr_swizzled_method(class,
                           @selector(observeValueForKeyPath:ofObject:change:context:),
                           @selector(cr_observeValueForKeyPath:ofObject:change:context:));
    });
}

#pragma mark 替换后的willMoveToSuperview
- (void)cr_willMoveToSuperview:(UIView *)newSuperview {
    // 移除旧的监听
    [self cr_removeObservers];
    
    // 有新的父组件，则添加新的监听
    if (newSuperview) {
        [self cr_addObservers];
    }
    
    [self cr_willMoveToSuperview:newSuperview];
}

#pragma mark 替换后的KVO接收消息方法
- (void)cr_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:CRScrollFadeKeyPath_ContentOffSet]) {
        // 对所有config对象发送消息
        [self.cr_configArray enumerateObjectsUsingBlock:^(CRScrollFadeConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 判断是否遵循协议
            if ([obj conformsToProtocol:@protocol(CRScrollFadeProtocol)]) {
                // 判断是否实现了该方法
                if ([obj respondsToSelector:@selector(cr_scrollViewContentOffSetDidChange:)]) {
                    // 发送消息
                    [(id<CRScrollFadeProtocol>)obj cr_scrollViewContentOffSetDidChange:change];
                }
            }
        }];
    }
    [self cr_observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

#pragma mark 使用static inline创建静态内联函数，方便调用
static inline void cr_swizzled_method(Class cls ,SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL isAdd = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAdd) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - Observer
- (void)cr_addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:CRScrollFadeKeyPath_ContentOffSet options:options context:nil];
}

- (void)cr_removeObservers {
    [self removeObserver:self forKeyPath:CRScrollFadeKeyPath_ContentOffSet];
}

#pragma mark - Param
- (NSMutableArray <CRScrollFadeConfig *> *)cr_configArray {
    NSMutableArray *tempConfigArray = objc_getAssociatedObject(self, _cmd);
    if (!tempConfigArray) {
        tempConfigArray = [NSMutableArray new];
        self.cr_configArray = tempConfigArray;
    }
    
    return tempConfigArray;
}

- (void)setCr_configArray:(NSMutableArray<CRScrollFadeConfig *> *)cr_configArray {
    objc_setAssociatedObject(self, @selector(cr_configArray), cr_configArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Process Config
- (void)cr_addScrollFadeConfig:(CRScrollFadeConfig *)scrollFadeConfig {
    if (scrollFadeConfig && [scrollFadeConfig isKindOfClass:[CRScrollFadeConfig class]]) {
        [self.cr_configArray addObject:scrollFadeConfig];
    }
}

- (void)cr_removeScrollFadeConfig:(CRScrollFadeConfig *)scrollFadeConfig {
    if (scrollFadeConfig && [scrollFadeConfig isKindOfClass:[CRScrollFadeConfig class]]) {
        if ([self.cr_configArray containsObject:scrollFadeConfig]) {
            [self.cr_configArray removeObject:scrollFadeConfig];
        }
    }
}

- (NSArray <CRScrollFadeConfig *> *)cr_getAllConfigArray {
    return [self.cr_configArray copy];
}

@end
