//
//  BaseUsageViewController.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "BaseUsageViewController.h"

@interface BaseUsageViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation BaseUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self relativeSuperView];
    
//    [self viewRelativeView];
    
//    [self labelView];
    
    [self multipliedView];
    
//    [self textFieldView];
}

/**
 相对superView
 */
- (void)relativeSuperView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:view];
    
    // 边距
    CGFloat marg = 20;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(marg);
        make.bottom.equalTo(self.view).offset(-marg);
        make.left.equalTo(self.view).offset(marg);
        make.right.equalTo(self.view).offset(-marg);
    }];
    
    dispatch_time_t tim = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    dispatch_after(dispatch_time(tim, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:5 animations:^{
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(marg*5, marg*5, marg*5, marg*5));
            }];
            [self.view layoutIfNeeded];
        }];
    });
}

/**
 视图之间相对位置
 让两个宽度为200的view 垂直居中且等宽等间距的排列 (自动计算高度)
 */
- (void)viewRelativeView{
    UIView *view_2 = [[UIView alloc] init];
    view_2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view_2];
    
    UIView *view_3 = [[UIView alloc] init];
    view_3.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view_3];
    
    CGFloat padding = 30;
    [view_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(padding*2);
        make.height.equalTo(view_3);
        make.width.mas_equalTo(@200);
    }];
    
    [view_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view_2.mas_centerX);
        make.top.equalTo(view_2.mas_bottom).offset(padding);
        make.bottom.equalTo(self.view.mas_bottom).offset(-padding);
        make.width.equalTo(view_2);
    }];
}

/*
 大于等于和小于等于某个值的约束
 */
- (void)labelView{
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = UIColor.orangeColor;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        //        make.width.lessThanOrEqualTo(@200);
        //        make.height.greaterThanOrEqualTo(@10);
        make.width.mas_lessThanOrEqualTo(@200);
        make.height.mas_greaterThanOrEqualTo(@10);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        label.text = @"alkd";
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        label.text = @"alkdfjlasdjflasjdflajsfljalasdfasdfjfjlsdjjsdf";
    });
}

/**
 设置当前约束值乘以多少，例如这个例子是redView的宽度是self.view宽度的0.5倍。
 */
- (void)multipliedView{
    UIView *redView = [UIView new];
    redView.backgroundColor = UIColor.redColor;
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(@100);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
}

/**
 mas_updateConstraints
 */
- (void)textFieldView{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-5);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.textField isFirstResponder] ?  [self.textField resignFirstResponder] : NSLog(@"");
}

#pragma mark - NSNotificationCenter
- (void)keyboardShow:(NSNotification *)noti{
    
    NSDictionary *dic = noti.userInfo;
    CGRect keyboardRect = [dic[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    CGFloat duration = [dic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight-5);
    }];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardHidden:(NSNotification *)noti{
    NSDictionary *userInfo   = noti.userInfo;
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
   
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UITextField *)textField{
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入...";
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:_textField];
    }
    return _textField;
}

@end
