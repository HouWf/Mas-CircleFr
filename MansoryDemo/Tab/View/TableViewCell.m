//
//  TableViewCell.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "TableViewCell.h"
#import "TabModel.h"
#import "UIView+Corner.h"
#import "MoreInfoContainerView.h"

@interface TableViewCell ()

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) MoreInfoContainerView *contView;



@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self maskCellView];
    }
    return self;
}

- (void)setModel:(TabModel *)model{
    if (!model) {
        return;
    }
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    self.nameLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.content;
    
    [self.contView reloadContainerViewWithArray:model.pictures];
}

- (void)maskCellView{
    
    CGFloat marg = 10;
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView).offset(marg);
        make.left.equalTo(self.contentView).offset(marg);
        make.height.mas_equalTo(40).priorityHigh();
        make.width.mas_equalTo(40);
    }];
    [self.headerView setCornerRadius:20
                      addRectCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.headerView);
        make.left.equalTo(self.headerView.mas_right).offset(marg);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_greaterThanOrEqualTo(10);
    }];

    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-marg);
        make.top.equalTo(self.headerView.mas_bottom).offset(marg);
        make.height.mas_greaterThanOrEqualTo(16).priorityHigh();

    }];

    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentLabel);
        make.right.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(marg);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.equalTo(self.nameLabel);
        make.top.equalTo(self.contView.mas_bottom).offset(marg).priorityHigh();
//        make.height.mas_greaterThanOrEqualTo(12);  // 自动
        make.width.mas_lessThanOrEqualTo(120);
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-marg);
    }];
    
    [self.contentView layoutIfNeeded];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Lazy
- (UIImageView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIImageView alloc] init];
        _headerView.backgroundColor = UIColor.lightGrayColor;
        [self.contentView addSubview:_headerView];
    }
    return _headerView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = [UIColor colorWithRed:155/255.f green:155/255.f blue:155/255.f alpha:1];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (MoreInfoContainerView *)contView{
    if (!_contView) {
        
        _contView = [[MoreInfoContainerView alloc] init];
        [self.contentView addSubview:_contView];
    }
    return _contView;
}

@end
