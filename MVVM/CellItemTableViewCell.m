//
//  CellItemTableViewCell.m
//  MVVM
//
//  Created by lanou on 16/4/28.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "CellItemTableViewCell.h"
#import "UIView+Custom.h"

/** 左边图片向左边距 */
#define ImageToLeft 15
/** 指示器向右边距 */
#define IndicatorToRight 15
/** 左边文字向图片的间距 */
#define LabelToImage 5
/** 左边文字向指示器的间距 */
#define DetailViewToIndicator 13
/** 屏幕宽度 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


@interface CellItemTableViewCell ()

@property (strong, nonatomic) UIImageView *imageViewLeft;
@property (strong, nonatomic) UIImageView *imageViewIndicator;
@property (strong, nonatomic) UIImageView *imageViewRight;

@property (strong, nonatomic) UILabel *labelLeft;
@property (strong, nonatomic) UILabel *labelRight;

@property (strong, nonatomic) UISwitch *Switch;

@end
@implementation CellItemTableViewCell

- (void)setItem:(CellItemModel *)item {
    _item = item;
    
    // 设置UI
    [self setupUI];
}

// 设置UI
- (void)setupUI {
    // 清空
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // SEL就是@selector类型, 实际上就是C语言字符串
    
    // 布局
    if (self.item.itemImage) {
        // 设置最左边的图片
        [self setupItemImage];
    }
    
    if (self.item.itemName) {
        // 设置最左边的文字
        [self setupItemName];
    }
    
    // 设置样式
    switch (self.item.type) {
        case CellItemTypeSysytem:
            [self setupTypeSystem];
            break;
        case CellItemTypeSwitch:
            [self setupTypeSwitch];
            break;
    }
    
    if (self.item.detailImage) {
        // 设置最右边的图片
        [self setupDetailImage];
    }
    
    if (self.item.detailName) {
        // 设置最右边的文字
        [self setupDetailName];
    }
    
    // 设置分割线
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, self.contentView.height - 1, kScreenWidth, 1);
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.05;
    [self.contentView addSubview:lineView];
}

// 清空
- (void)removeFromSuperview {
    
}

// 设置最左边的图片
- (void)setupItemImage {
    self.imageViewLeft = [[UIImageView alloc]initWithImage:self.item.itemImage];
    self.imageViewLeft.x = ImageToLeft;
    CGPoint center = self.imageViewLeft.center;
    CGPoint center1 = self.contentView.center;
    center.y = center1.y;
    self.imageViewLeft.center = center;
    [self.contentView addSubview:self.imageViewLeft];
}

// 设置最左边的文字
- (void)setupItemName {
    self.labelLeft = [[UILabel alloc]init];
    self.labelLeft.text = self.item.itemName;
    self.labelLeft.font = [UIFont systemFontOfSize:14];
    
    self.labelLeft.size = [self.labelLeft.text boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX) options:0 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
//    CGPoint center = self.labelLeft.center;
//    CGPoint center1 = self.contentView.center;
//    center.y = center1.y;
//    self.labelLeft.center = center;
    self.labelLeft.centerY = self.contentView.centerY;
    self.labelLeft.x = CGRectGetMaxX(self.imageViewLeft.frame) + LabelToImage;
    [self.contentView addSubview:self.labelLeft];
}

// 设置样式 - system
- (void)setupTypeSystem {
    [self.contentView addSubview:self.imageViewIndicator];
}
//　设置样式 - switch
- (void)setupTypeSwitch {
    [self.contentView addSubview:self.Switch];
}

// 设置最右边的图片
- (void)setupDetailImage {
    self.imageViewRight = [[UIImageView alloc] initWithImage:self.item.detailImage];
    self.imageViewRight.centerY = self.contentView.centerY;
    switch (self.item.type) {
        case CellItemTypeSysytem:
            self.imageViewRight.x = self.imageViewIndicator.x - self.imageViewRight.width - DetailViewToIndicator;
            break;
        case CellItemTypeSwitch:
            self.imageViewRight.x = self.Switch.x - self.imageViewRight.width - DetailViewToIndicator;
            break;
        default:
            break;
    }
    [self.contentView addSubview:self.imageViewRight];
}
// 设置最右边的文字
- (void)setupDetailName {
    self.labelRight = [[UILabel alloc]init];
    self.labelRight.text = self.item.detailName;
    self.labelRight.font = [UIFont systemFontOfSize:14];
    
    
    self.labelRight.size = [self.labelRight.text boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX) options:0 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
    
    self.labelRight.centerY = self.contentView.centerY;
    
    switch (self.item.type) {
        case CellItemTypeSysytem:
            self.labelRight.x =  self.imageViewIndicator.x - self.labelRight.width - DetailViewToIndicator;
            break;
        case CellItemTypeSwitch:
            self.labelRight.x = self.Switch.x - self.labelRight.width - DetailViewToIndicator;
            break;
        default:
            break;
    }
    [self.contentView addSubview:self.labelRight];
}


#pragma mark ----懒加载
- (UIImageView *)imageViewIndicator {
    if (!_imageViewIndicator) {
        _imageViewIndicator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-arrow1"]];
//        CGPoint center = self.labelLeft.center;
//        CGPoint center1 = self.contentView.center;
//        center.y = center1.y;
//        self.imageViewIndicator.center = center;
        self.imageViewIndicator.centerY = self.contentView.centerY;
        self.imageViewIndicator.x = kScreenWidth - self.imageViewIndicator.width - IndicatorToRight;
    }
    return _imageViewIndicator;
}

- (UISwitch *)Switch {
    if (!_Switch) {
        _Switch = [[UISwitch alloc]init];
        CGPoint center = self.labelLeft.center;
        CGPoint center1 = self.contentView.center;
        center.y = center1.y;
        self.Switch.center = center;
        self.Switch.x = kScreenWidth - self.Switch.width - IndicatorToRight;
        [self.Switch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _Switch;
}
- (void)valueChanged:(UISwitch *)Switch {
    if (self.item.SwitchValueChanged) {
        self.item.SwitchValueChanged(Switch.isOn);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
