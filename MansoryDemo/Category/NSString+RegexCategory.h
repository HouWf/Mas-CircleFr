//
//  NSString+RegexCategory.h
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/8.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RegexCategory)

-(CGSize) sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

+(CGSize) sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
