//
//  PictureView.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/4.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "PictureView.h"
#import "YBIBFileManager.h"

@implementation PictureView

- (instancetype)init{
    if (self == [super init]) {
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.playIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 15));
        }];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = RGBA(155, 155, 155, 1);
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIImageView *)playIconView{
    if (!_playIconView) {
        _playIconView = [[UIImageView alloc] init];
        _playIconView.image =  [YBIBFileManager getImageWithName:@"ybib_bigPlay"];
        [self addSubview:_playIconView];
    }
    return _playIconView;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.backgroundColor = UIColor.blackColor;
        _typeLabel.textColor = UIColor.whiteColor;
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_typeLabel];
    }
    return _typeLabel;
}

@end
