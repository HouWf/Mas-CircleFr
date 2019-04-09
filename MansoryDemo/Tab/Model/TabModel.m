//
//  TabModel.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "TabModel.h"
#import "NSString+RegexCategory.h"

extern CGFloat maxContentLabelHeigth;

@interface TabModel ()
{
    CGFloat _lastContentWidth;
}

@end

@implementation TabModel

@synthesize content = _content;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)modelWithDictionary:(NSDictionary *)dic{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic
{
    return [[self alloc] modelWithDictionary:dic];
}

- (void)setContent:(NSString *)content{
    _content = content;
}

- (NSString *)content{
    CGFloat maxWidth = Main_Screen_Width - 100;
    if (maxWidth != _lastContentWidth) {
        _lastContentWidth = maxWidth;
        CGFloat textHeight = [self.content sizeOfTextWithMaxSize:CGSizeMake(maxWidth, MAXFLOAT) font:[UIFont systemFontOfSize:12]].height;
        self.shouldShowMoreButton = textHeight > maxContentLabelHeigth;
    }
    
    return _content;
}
/*
 这样设置不行  奇怪
 */
//- (void)mj_keyValuesDidFinishConvertingToObject{
//
//    if (self.content.length) {
//        CGFloat maxWidth = Main_Screen_Width - 100;
//        if (maxWidth != _lastContentWidth) {
//            _lastContentWidth = maxWidth;
//            CGFloat textHeight = [self.content sizeOfTextWithMaxSize:CGSizeMake(maxWidth, MAXFLOAT) font:[UIFont systemFontOfSize:12]].height;
//            self.shouldShowMoreButton = textHeight > maxContentLabelHeigth;
//        }
//    }
//}

- (void)setIsOpening:(BOOL)isOpening{
    if (!self.shouldShowMoreButton) {
        _isOpening = NO;
    }
    else{
        _isOpening = isOpening;
    }
}

@end
