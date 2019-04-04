//
//  TableViewCell.h
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabModel;

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) TabModel *model;

@property (nonatomic, copy) void(^tableBlock)(TableViewCell *cell, NSInteger selectedIndex);

@end

NS_ASSUME_NONNULL_END
