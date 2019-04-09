//
//  NSString+RegexCategory.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/8.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "NSString+RegexCategory.h"

@implementation NSString (RegexCategory)

-(CGSize) sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font{
    NSDictionary * dict = @{NSFontAttributeName:font};
    
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return size;
}

+(CGSize) sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}

@end
