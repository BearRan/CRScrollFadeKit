//
//  CRScrollFadeConst.h
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/9.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CRScrollFadeDirection) {
    CRScrollFadeDirection_Vert, // 垂直方向
    CRScrollFadeDirection_Horz, // 水平方向
};

@protocol CRScrollFadeProtocol <NSObject>

@optional
- (void)cr_scrollViewContentOffSetDidChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView;

@end


UIKIT_EXTERN NSString *const CRScrollFadeKeyPath_ContentOffSet;

@interface CRScrollFadeConst : NSObject

@end

NS_ASSUME_NONNULL_END
