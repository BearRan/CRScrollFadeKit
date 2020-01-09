//
//  UIScrollView+CRScrollFadeKit.h
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRScrollFadeConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CRScrollFadeKit)

#pragma mark - Process Config
- (void)crScrollFade_addScrollFadeConfig:(CRScrollFadeConfig *)scrollFadeConfig;
- (void)crScrollFade_removeScrollFadeConfig:(CRScrollFadeConfig *)scrollFadeConfig;
- (NSArray <CRScrollFadeConfig *> *)crScrollFade_getAllConfigArray;

@end

NS_ASSUME_NONNULL_END
