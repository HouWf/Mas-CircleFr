//
//  TabViewController.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "TabViewController.h"
#import "TableViewCell.h"
#import "TabModel.h"

static NSString *main_tab_identifier = @"main_tab_identifier";

@interface TabViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *main_tableView;

@property (nonatomic, strong) NSMutableArray <TabModel *> *dataSource;

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.main_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self loadData:^(BOOL result) {
        if (result) {
            [self.main_tableView reloadData];
        }
    }];
}

- (void)loadData:(void(^)(BOOL result))block{
    
    self.dataSource = [NSMutableArray arrayWithCapacity:10];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tabresource" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray *arry = dataDic[@"data_list"];
    if (error) {
        NSLog(@"json解析错误");
        block(NO);
    }
    else{
        self.dataSource = [TabModel mj_objectArrayWithKeyValuesArray:arry];
    }
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:main_tab_identifier];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:main_tab_identifier];
    }
    cell.model = self.dataSource[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.tableBlock = ^(TabModel * _Nonnull selecteModel) {
        __strong typeof(weakSelf) self = weakSelf;
        selecteModel.isOpening = !selecteModel.isOpening;
        [self.main_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];        
    };
    return cell;
}

#pragma mark - Lazy
- (UITableView *)main_tableView{
    if (!_main_tableView) {
        
        _main_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _main_tableView.delegate = self;
        _main_tableView.dataSource = self;
        _main_tableView.tableFooterView = [UIView new];
        _main_tableView.rowHeight = UITableViewAutomaticDimension;
        _main_tableView.estimatedRowHeight = 200;
//        [_main_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:main_tab_identifier];
        [self.view addSubview:_main_tableView];
    }
    return _main_tableView;
}

@end
