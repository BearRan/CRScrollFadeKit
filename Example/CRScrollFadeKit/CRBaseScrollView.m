//
//  CRBaseScrollView.m
//  CRScrollFadeKit_Example
//
//  Created by cc Chobit on 2020/1/10.
//  Copyright © 2020 BearRan. All rights reserved.
//

#import "CRBaseScrollView.h"

@implementation CRBaseScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"---change origin:%@", change);
}

@end
