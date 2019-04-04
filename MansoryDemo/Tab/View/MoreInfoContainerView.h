//
//  MoreInfoContainerView.h
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/4.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreInfoContainerView : UIView

// 图片宽度
@property (nonatomic, assign) CGFloat pictureWidth;
// 图片高/宽比例
@property (nonatomic, assign) CGFloat autoHeight;
// 每页显示数
@property (nonatomic, assign) NSInteger perRowItemCount;


- (void)reloadContainerViewWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
