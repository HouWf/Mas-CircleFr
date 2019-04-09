//
//  MoreInfoContainerView.m
//  MansoryDemo
//
//  Created by hzhy001 on 2019/4/4.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "MoreInfoContainerView.h"
#import "PictureView.h"

#define kMaxWidth 300*kScreenWidthRatio
#define Marg 10
#define kItemSpace Marg

@interface MoreInfoContainerView ()

@property (nonatomic, strong) NSMutableArray <PictureView *>*pictureViewArray;

@property (nonatomic, strong) NSMutableArray <NSString *>*sourceArray;


@end

@implementation MoreInfoContainerView

- (instancetype)init{
    if (self == [super init]) {
        [self addView];
    }
    return self;
}

- (void)reloadContainerViewWithArray:(NSArray *)array{
//    NSLog(@"self.frame = %@", NSStringFromCGRect(self.frame));
    
    NSArray *tempArray = [NSArray arrayWithArray:array];
    if (tempArray.count > 9) {
        tempArray = [tempArray subarrayWithRange:NSMakeRange(0, 9)];
    }
    self.sourceArray = [NSMutableArray arrayWithArray:tempArray];
   
    for (long i = self.sourceArray.count; i < self.pictureViewArray.count; i++) {
        PictureView *imageView = [self.pictureViewArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (array.count == 0) {
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(0);
        }];
        return;
    }
    
#if 1
    long perRowItemCount = [self perRowItemCountForPicPathArray:self.sourceArray];
    CGFloat itemWidth = [self itemWidthForPicPathArray:self.sourceArray];
    CGFloat itemHeight = itemWidth; // self.sourceArray.count == 1 ? itemWidth * 1.2 : itemWidth;
   
    [self.sourceArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        PictureView *imageView = [self.pictureViewArray objectAtIndex:idx];
        imageView.hidden = NO;
        [self refreshUiWithString:obj imageView:imageView];
        
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(columnIndex * (itemWidth + Marg));
            make.top.mas_equalTo(rowIndex * (itemHeight + Marg));
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemHeight);
        }];
    }];

    CGFloat w = perRowItemCount * itemWidth + (perRowItemCount - 1) * kItemSpace;
    int columnCount = ceilf(self.sourceArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemHeight + (columnCount - 1) * kItemSpace;
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h);
        make.width.mas_equalTo(w);
    }];
#else
    // !!!: 会报布局警告
    // 设置宽高及布局
    if (self.sourceArray.count == 1) {
        CGFloat itemWidth = [self itemWidthForPicPathArray:self.sourceArray];

        PictureView *imageView = self.pictureViewArray[0];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(itemWidth);
            make.height.equalTo(imageView.mas_width).multipliedBy(1.2);
            make.top.left.equalTo(self);

            make.bottom.equalTo(self);
        }];
    }
    else if (self.sourceArray.count == 2){
        PictureView *imageView0 = self.pictureViewArray[0];
        PictureView *imageView1 = self.pictureViewArray[1];

        [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.height.equalTo(self);
            make.width.equalTo(imageView1);
        }];

        [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self);
            make.left.equalTo(imageView0.mas_right).offset(kItemSpace);
            make.height.mas_equalTo(imageView1.mas_width);

            make.bottom.equalTo(imageView0);
        }];
    }
    else{
        CGFloat lineSp      = Marg;
        CGFloat inteSp      = lineSp;
        CGFloat count       = [self perRowItemCountForPicPathArray:self.sourceArray];;
        CGFloat itemWidth   = [self itemWidthForPicPathArray:self.sourceArray];
        CGFloat itemHeight  = itemWidth;

        [self.subviews mas_distributeSudokuViewsWithFixedItemWidth:0   // 宽度自适应
                                                   fixedItemHeight:itemHeight
                                                  fixedLineSpacing:lineSp
                                             fixedInteritemSpacing:inteSp
                                                         warpCount:count
                                                        topSpacing:0
                                                     bottomSpacing:0
                                                       leadSpacing:0
                                                       tailSpacing:0];
    }

    // 填充视图
    [self.sourceArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self refreshUiWithString:obj imageView:self.pictureViewArray[idx]];
    }];
#endif
}

- (void)refreshUiWithString:(NSString *)imageStr imageView:(PictureView *)imgView{
    CGSize size = imgView.frame.size;
    if ([imageStr hasSuffix:@".MP4"]) {
        AVURLAsset *avAsset = nil;
        if ([imageStr hasPrefix:@"http"]) {
            avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:imageStr]];
        } else {
            NSString *path = [[NSBundle mainBundle] pathForResource:imageStr.stringByDeletingPathExtension ofType:imageStr.pathExtension];
            avAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
        }
        
        if (avAsset) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:avAsset];
                generator.appliesPreferredTrackTransform = YES;
                generator.maximumSize = size;
                NSError *error = nil;
                CGImageRef cgImage = [generator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:NULL error:&error];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imgView.imageView.image = [UIImage imageWithCGImage:cgImage];
                });
            });
        }
    }
    else if ([imageStr hasPrefix:@"http"]){
         [imgView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    }
    else{
        imgView.imageView.image = [UIImage imageNamed:imageStr];
    }
    
    if ([imageStr hasSuffix:@".MP4"]) {
        imgView.playIconView.hidden = NO;
        imgView.typeLabel.hidden = YES;
    } else if ([imageStr hasSuffix:@".gif"]) {
        imgView.playIconView.hidden = YES;
        imgView.typeLabel.hidden = NO;
        imgView.typeLabel.text = @" GIF ";
    } else {
        imgView.playIconView.hidden = YES;
        imgView.typeLabel.hidden = YES;
    }
}

/**
 获取宽度
 
 @param picArray 图片数组
 @return 宽度
 */
- (CGFloat)itemWidthForPicPathArray:(NSArray *)picArray{
    if (self.pictureWidth != 0) {
        return self.pictureWidth;
    }
    else{
        if (picArray.count == 1) {
            return kMaxWidth/2;
        }
        else if (picArray.count == 2){
            return (kMaxWidth-kItemSpace)/2.f;
        }
        else{
            return (kMaxWidth - 2*kItemSpace)/3.f;
        }
    }
}

/**
 获取每行展示图片数
 
 @param array 图片数组
 @return 数量
 */
- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (self.perRowItemCount != 0) {
        return self.perRowItemCount;
    }
    else{
        if (array.count < 3) {
            return array.count;
        }
        else {
            return 3;
        }
    }
}

- (void)addView{
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:9];
    for (NSInteger i =0 ; i < 9 ; i ++) {
        
        PictureView *picView = [[PictureView alloc] init];
        picView.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [picView addGestureRecognizer:tap];
        
        [self addSubview:picView];
        [temp addObject:picView];
    }
    self.pictureViewArray = [temp copy];
}

// 点击放大
- (void)tapClick:(UIGestureRecognizer *)gesture{
    
    PictureView *view = (PictureView *)gesture.view;
    NSInteger selectedIndex = view.tag;
    
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [self.sourceArray enumerateObjectsUsingBlock:^(NSString *_Nonnull imageStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 此处只是为了判断测试用例的数据源是否为视频，并不是仅支持 MP4。/ This is just to determine whether the data source of the test case is video, not just MP4.
        if ([imageStr hasSuffix:@".MP4"]) {
            if ([imageStr hasPrefix:@"http"]) {
                
                // Type 1 : 网络视频 / Network video
                YBVideoBrowseCellData *data = [YBVideoBrowseCellData new];
                data.url = [NSURL URLWithString:imageStr];
                data.sourceObject = self.pictureViewArray[idx];
                [browserDataArr addObject:data];
                
            } else {
                
                // Type 2 : 本地视频 / Local video
                NSString *path = [[NSBundle mainBundle] pathForResource:imageStr.stringByDeletingPathExtension ofType:imageStr.pathExtension];
                NSURL *url = [NSURL fileURLWithPath:path];
                YBVideoBrowseCellData *data = [YBVideoBrowseCellData new];
                data.url = url;
                data.sourceObject = self.pictureViewArray[idx];
                [browserDataArr addObject:data];
                
            }
        } else if ([imageStr hasPrefix:@"http"]) {
            
            // Type 3 : 网络图片 / Network image
            YBImageBrowseCellData *data = [YBImageBrowseCellData new];
            data.url = [NSURL URLWithString:imageStr];
            data.sourceObject = self.pictureViewArray[idx];
            [browserDataArr addObject:data];
            
        } else {
            
            // Type 4 : 本地图片 / Local image (配置本地图片推荐使用 YBImage)
            YBImageBrowseCellData *data = [YBImageBrowseCellData new];
            data.imageBlock = ^__kindof UIImage * _Nullable{
                return [YBImage imageNamed:imageStr];
            };
            data.sourceObject = self.pictureViewArray[idx];
            [browserDataArr addObject:data];
        }
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = selectedIndex;
    [browser show];
}

@end
