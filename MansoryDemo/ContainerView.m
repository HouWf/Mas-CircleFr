//
//  ContainerView.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/3.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "ContainerView.h"
#import "NSArray+Squared.h"

@implementation ContainerView

- (instancetype)init{
    if (self == [super init]) {
        
        [self loadMoreView];
        CGFloat main_width = [UIScreen mainScreen].bounds.size.width;
        CGFloat totalSp = 40;
        CGFloat lineSp  = 10;
        CGFloat inteSp  = lineSp;
        CGFloat count   = 3;
        CGFloat leadSp  = 5;
        CGFloat tailSp  = leadSp;
        CGFloat width   = (main_width - totalSp - 2 * leadSp - 2 * lineSp)/count;
        CGFloat height  = width; //150;
        
        [self.subviews mas_distributeSudokuViewsWithFixedItemWidth:width
                                                   fixedItemHeight:height
                                                  fixedLineSpacing:lineSp
                                             fixedInteritemSpacing:inteSp
                                                         warpCount:count
                                                        topSpacing:5
                                                     bottomSpacing:5
                                                       leadSpacing:leadSp
                                                       tailSpacing:tailSp];
        
    }
    return self;
}

- (void)loadMoreView{
    for (int i = 0; i < 10; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.orangeColor;
        [self addSubview:view];
    }
}

@end
