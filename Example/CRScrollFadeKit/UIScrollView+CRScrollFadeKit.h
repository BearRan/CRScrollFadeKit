//
//  UIScrollView+CRScrollFadeKit.h
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRScrollFadeListener.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CRScrollFadeKit)

#pragma mark - Process Config
- (void)cr_addScrollFadeListener:(CRScrollFadeListener *)scrollFadeListener;
- (void)cr_removeScrollFadeListener:(CRScrollFadeListener *)scrollFadeListener;
- (NSArray <CRScrollFadeListener *> *)cr_getAllListenerArray;

@end

NS_ASSUME_NONNULL_END
