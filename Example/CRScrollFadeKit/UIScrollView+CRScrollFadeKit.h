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
- (void)cr_addScrollFadeConfig:(CRScrollFadeConfig *)scrollFadeConfig;
- (void)cr_removeScrollFadeConfig:(CRScrollFadeConfig *)scrollFadeConfig;
- (NSArray <CRScrollFadeConfig *> *)cr_getAllConfigArray;

@end

NS_ASSUME_NONNULL_END
