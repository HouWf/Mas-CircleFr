//
//  TabModel.h
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray *pictures;


// 是否展示更多按钮
@property (nonatomic, assign) BOOL shouldShowMoreButton;

// 是否已展开
@property (nonatomic, assign) BOOL isOpening;

//+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
