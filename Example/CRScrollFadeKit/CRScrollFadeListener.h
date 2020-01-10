//
//  CRScrollFadeListener.h
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRScrollFadeConst.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^FadeValueChangedBlock)(CGFloat fadeValue);

@interface CRScrollFadeListener : NSObject

/** 监听滑动方向
 *  默认：CRScrollFadeDirection_Vert 垂直方向
 */
@property(nonatomic, assign) CRScrollFadeDirection fadeDirection;

/** 监听变化的起始位置
 *  默认：0
 *  对应fadeValue = 0
 */
@property(nonatomic, strong) NSNumber *fadeStartValue; // 0, fadeValue = 0

/** 监听变化的终止位置
 *  默认：100
 *  对应fadeValue = 1
 */
@property(nonatomic, strong) NSNumber *fadeEndValue; // 100, fadeValue = 1

/** 内边距
 *  用于偏移处理
 */
@property(nonatomic, assign) UIEdgeInsets contentInset;

/** fadeValue
 *  0~1
 */
@property(nonatomic, assign, readonly) CGFloat fadeValue;

// fadeValue改变时的回调
@property(nonatomic, copy) FadeValueChangedBlock fadeValueChangedBlock;

+ (CRScrollFadeListener *)defaultConfig;

@end

NS_ASSUME_NONNULL_END
