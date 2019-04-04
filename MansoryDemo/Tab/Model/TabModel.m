//
//  TabModel.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "TabModel.h"

@implementation TabModel

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

/*

 "pictures":[
 "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118772581&di=29b994a8fcaaf72498454e6d207bc29a&imgtype=0&src=http%3A%2F%2Fimglf2.ph.126.net%2F_s_WfySuHWpGNA10-LrKEQ%3D%3D%2F1616792266326335483.gif",
 "http://pic37.nipic.com/20140110/17563091_221827492154_2.jpg",
 "http://pic36.nipic.com/20131129/8821914_111419739001_2.jpg",
 "http://pic36.nipic.com/20131203/12728082_134842497000_2.jpg",
 "http://pic31.nipic.com/20130721/5452164_091918765108_2.jpg",
 "http://img.redocn.com/sheying/20140731/qinghaihuyuanjing_2820969.jpg",
 "http://pic13.nipic.com/20110331/7053919_100607336160_2.jpg"
 ]
 */

@end
