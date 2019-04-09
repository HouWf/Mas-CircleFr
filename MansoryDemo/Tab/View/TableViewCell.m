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

CGFloat maxContentLabelHeigth = 0;

CGFloat marg = 10;

@interface TableViewCell ()

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *moreButton;

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
    
    _model = model;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    self.nameLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.content;
    [self.contView reloadContainerViewWithArray:model.pictures];
    
    [self resetView:model];
}

/**
 更新布局
 */
- (void)resetView:(TabModel *)model{
    
    // 展开按钮 离文字内容距离、按钮高度
    CGFloat bottonTopMarg = 0;
    CGFloat bottonHeight = 0;
    NSString *buttonTitle = @"全文";
    // 文字内容最大高度
    CGFloat contentLessHeight = maxContentLabelHeigth;
    // 图片内容顶部距离
    CGFloat pictureViewTopMarg = 0;
    
    if (model.shouldShowMoreButton) {
        bottonTopMarg = marg;
        bottonHeight = 20;
        
        if (model.isOpening) {
            contentLessHeight = MAXFLOAT;
            buttonTitle = @"收起";
        }
    }
    
    if (model.pictures.count) {
        pictureViewTopMarg = marg;
    }
    
    // 更新UI
    self.moreButton.hidden = !model.shouldShowMoreButton;
    [self.moreButton setTitle:buttonTitle forState:UIControlStateNormal];

    // 更新布局
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo(contentLessHeight);
    }];
    
    [self.moreButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(bottonTopMarg);
        make.height.mas_equalTo(bottonHeight);
    }];
    
    [self.contView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreButton.mas_bottom).offset(pictureViewTopMarg).priorityHigh();
        make.left.equalTo(self.nameLabel);
    }];
    
    //    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
}

- (void)maskCellView{
    
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
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(marg);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];

    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.equalTo(self.nameLabel);
//        make.right.equalTo(self.contentLabel);
        make.top.equalTo(self.moreButton.mas_bottom).offset(marg);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.equalTo(self.nameLabel);
        make.top.equalTo(self.contView.mas_bottom).offset(marg).priorityHigh();
//        make.height.mas_greaterThanOrEqualTo(12);  // 自动
        make.width.mas_lessThanOrEqualTo(120);
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-marg);
    }];
    
    MASAttachKeys(self.timeLabel,self.contView, self.moreButton,self.contentLabel,self.nameLabel,self.headerView);
    
    [self.contentView layoutIfNeeded];
}

- (void)moreButtonClicked{
    if (self.tableBlock) {
        self.tableBlock(self.model);
    }
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
        if (maxContentLabelHeigth == 0) {
            maxContentLabelHeigth = _contentLabel.font.lineHeight * 4;
        }
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        [_moreButton setTitleColor:RGBA(41, 122, 204, 1) forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [self.contentView addSubview:_moreButton];
    }
    return _moreButton;
}

- (MoreInfoContainerView *)contView{
    if (!_contView) {
        
        _contView = [[MoreInfoContainerView alloc] init];
        [self.contentView addSubview:_contView];
    }
    return _contView;
}

@end
