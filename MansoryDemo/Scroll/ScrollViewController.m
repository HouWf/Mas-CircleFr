//
//  ScrollViewController.m
//  MansoryDemo
//
//  Created by hzhy001 on 2018/8/16.
//  Copyright © 2018年 hzhy001. All rights reserved.
//

#import "ScrollViewController.h"
#import "ContainerView.h"

@interface ScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *containView;

@end

@implementation ScrollViewController

/**
 在UIScrollView中顺序排列一些view并自动计算contentSize
 
 这种方式的实现，主要是依赖于创建一个containerView内容视图，并添加到UIScrollView上作为子视图。
 UIScrollView原来的子视图都添加到containerView上，并且和这个视图设置约束。
 
 因为对UIScrollView进行addSubview操作的时候，本质上是往其contentView上添加。
 也就是containerView的父视图是contentView，通过containerView撑起contentView视图的大小，以此来实现动态改变contentSize。
 
 在进行约束的时候，要对containerView的上下左右都添加和子视图的约束，以便确认containerView的边界区域。
 这个containView是用来先填充整个scrollView的,到时候这个containView的size就是scrollView的contentSize
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
   
//    [self resouse];
    
//    [self firstMethod];
    
//    [self nextMethod];
    
    [self otherMethod];
    
    [self.view layoutIfNeeded];

    NSLog(@"size = %@",NSStringFromCGSize(self.scrollView.frame.size));
    NSLog(@"contentSize = %@",NSStringFromCGSize(self.scrollView.contentSize));
}

/**
 基础原理：控件内容撑开父类尺寸
 */
- (void)resouse{
    UIView* bgView       = [UIView new];
    bgView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:bgView];
    
    UILabel* titleLab        = [UILabel new];
    titleLab.backgroundColor = [UIColor redColor];
    titleLab.textAlignment   = NSTextAlignmentCenter;
    titleLab.font            = [UIFont systemFontOfSize:15.f];
    titleLab.text            = @"曹操——《短歌行》";
    [bgView addSubview:titleLab];
    
    UILabel* contentLab        = [UILabel new];
    contentLab.numberOfLines   = 0 ;
    contentLab.textAlignment   = NSTextAlignmentCenter;
    contentLab.backgroundColor = [UIColor brownColor];
    contentLab.font            = [UIFont systemFontOfSize:13.f];
    contentLab.text            = @" 对酒当歌，人生几何？ 譬如朝露，去日苦多。\n 慨当以慷，忧思难忘。 何以解忧？唯有杜康。\n 青青子衿，悠悠我心。 但为君故，沉吟至今。\n 呦呦鹿鸣，食野之苹。 我有嘉宾，鼓瑟吹笙。\n 明明如月，何时可掇？ 忧从中来，不可断绝。\n 越陌度阡，枉用相存。 契阔谈宴，心念旧恩。\n 月明星稀，乌鹊南飞。 绕树三匝，何枝可依？\n 山不厌高，海不厌深。 周公吐哺，天下归心。";
    
    [bgView addSubview:contentLab];
    
    //思路: 父视图的上间距等于title的上间距,父视图的下间距等于content的下间距
    __weak typeof(self) weakSelf = self;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@30);
        make.right.mas_offset(@-30);
        make.centerY.equalTo(weakSelf.view);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(@0);
    }];
    
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(@0);
        make.top.equalTo(titleLab.mas_bottom).mas_offset(@10);
        make.bottom.equalTo(bgView);
    }];
    
}

// 纵向
- (void)firstMethod{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(74, 10, 10, 10));
    }];
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    UIView *lastView = nil;
    for (int i = 0; i<6; i++) {
        UIView *sub_view = [UIView new];
        sub_view.backgroundColor =  [UIColor colorWithHue:( arc4random() % 256 / 256.0 )    // 色调
                                               saturation:( arc4random() % 128 / 256.0 ) + 0.5  // 饱和度
                                               brightness:( arc4random() % 128 / 256.0 ) + 0.5  // 亮度
                                                    alpha:1];
        [self.containView addSubview:sub_view];
        
        [sub_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.containView);
            make.height.mas_equalTo(@(30*i));
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom);
            }
            else{
                make.top.mas_equalTo(self.containView.mas_top);
            }
        }];
        lastView = sub_view;
    }
    
    // 最后更新containView
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

// 横向
- (void)nextMethod{
    CGFloat padding = 10;

    // 在进行约束的时候，要对containerView的上下左右都添加和子视图的约束，以便确认containerView的边界区域。
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(74, padding, padding, padding));
    }];
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView).insets(UIEdgeInsetsMake(padding, padding, padding, padding));
    }];
    
    UIView *greenView = [UIView new];
    UIView *redView = [UIView new];
    UIView *yellowView = [UIView new];

    greenView.backgroundColor = UIColor.greenColor;
    redView.backgroundColor = UIColor.redColor;
    yellowView.backgroundColor = UIColor.yellowColor;
    
    [self.containView addSubview:greenView];
    [self.containView addSubview:redView];
    [self.containView addSubview:yellowView];

    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.containView).offset(padding);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containView).offset(padding);
        make.left.equalTo(greenView.mas_right).offset(padding);
        make.size.equalTo(greenView);
        make.right.equalTo(self.containView).offset(-padding);
    }];
    
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView).offset(padding);
        make.top.equalTo(greenView.mas_bottom).offset(padding);
        make.size.equalTo(greenView);
        make.bottom.equalTo(self.containView).offset(-padding);
    }];
}

/**
 九宫格
 */
- (void)otherMethod{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(74, 10, 10, 10));
    }];
    
    ContainerView *conView = [[ContainerView alloc] init];
    conView.backgroundColor = UIColor.greenColor;
    [self.scrollView addSubview:conView];
    
    [conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)containView{
 
    if (!_containView) {
        _containView = [UIView new];
        _containView.backgroundColor = [UIColor orangeColor];
        [self.scrollView addSubview:_containView];
    }
    return _containView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
