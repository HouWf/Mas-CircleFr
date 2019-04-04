//
//  OtherViewController.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/3.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *yellowView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *greenView;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
//    [self method_1];
    
//    [self method_2];
    
    [self method_3];
}

/**
 *  多个控件固定间隔的等间隔排列，变化的是控件的长度或者宽度值
 *
 *   axisType        轴线方向
 *   fixedSpacing    间隔大小
 *   fixedItemLength 每个控件的固定长度或者宽度值
 *   leadSpacing     头部间隔
 *   tailSpacing     尾部间隔
 */
- (void)method_1{
    
    NSArray *arr = @[self.redView, self.yellowView, self.blueView];
   
#if 1
     // 多个控件固定间隔的等间隔排列，变化的是控件的长度或者宽度值
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                     withFixedSpacing:20
                          leadSpacing:10
                          tailSpacing:10];
    
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.height.mas_equalTo(100);
    }];
#else
    // 多个固定大小的控件的等间隔排列,变化的是间隔的空隙
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical
                        withFixedItemLength:60
                                leadSpacing:74
                                tailSpacing:10];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(70);
//        make.height.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
#endif
    
}

- (void)method_2{
    NSArray *arr = @[self.redView, self.yellowView, self.blueView, self.greenView];
    for (NSUInteger i = 0; i < arr.count; i++) {
        UIView *itemView = arr[i];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@(50));
            make.centerY.equalTo(self.view.mas_centerY);
            make.centerX.equalTo(self.view.mas_right).multipliedBy(((CGFloat)i + 1) / ((CGFloat)arr.count + 1));
        }];
    }
}

- (void)method_3{
    UIView* bgView       = [UIView new];
    bgView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:bgView];
    
    UILabel* titleLab        = [UILabel new];
    titleLab.backgroundColor = [UIColor redColor];
    titleLab.textAlignment   = NSTextAlignmentCenter;
    titleLab.font            = [UIFont systemFontOfSize:15.f];
    titleLab.text            = @"这是测试内容";
    [bgView addSubview:titleLab];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(74);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10); // equalTo(bgView).offset(10);
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo(5);
//        make.height.mas_equalTo(30);
//
//        make.bottom.equalTo(bgView).offset(-5);
        
        make.edges.equalTo(bgView).insets(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
}

- (UIView *)redView{
    if (!_redView) {
        
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = UIColor.redColor;
        [self.view addSubview:_redView];
    }
    return _redView;
}

- (UIView *)yellowView{
    if (!_yellowView) {
        
        _yellowView = [[UIView alloc] init];
        _yellowView.backgroundColor = UIColor.yellowColor;
        [self.view addSubview:_yellowView];
    }
    return _yellowView;
}

- (UIView *)blueView{
    if (!_blueView) {
        
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = UIColor.blueColor;
        [self.view addSubview:_blueView];
    }
    return _blueView;
}

- (UIView *)greenView{
    if (!_greenView) {
        
        _greenView = [[UIView alloc] init];
        _greenView.backgroundColor = UIColor.greenColor;
        [self.view addSubview:_greenView];
    }
    return _greenView;
}

@end
