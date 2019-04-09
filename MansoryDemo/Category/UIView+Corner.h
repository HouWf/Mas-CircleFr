//
//  UIView+Corner.h
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corner)

- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;

@end

NS_ASSUME_NONNULL_END
