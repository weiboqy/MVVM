//
//  CellItemModel.h
//  MVVM
//
//  Created by lanou on 16/4/28.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 枚举 */
typedef NS_ENUM(NSInteger,CellItemType) {
    CellItemTypeSysytem,
    CellItemTypeSwitch
};

@interface CellItemModel : NSObject

/** 左边的label */
@property (nonatomic, copy) NSString *itemName;
/** 左边的图片 */
@property (nonatomic, strong) UIImage *itemImage;
/** 右边的label */
@property (nonatomic, copy)NSString *detailName;
/** 右边的图片 */
@property (nonatomic, strong)UIImage *detailImage;

/** 开关变化执行的回调 */
@property (nonatomic, copy)void (^SwitchValueChanged)(BOOL isOn);

/** 点击item执行的回调 */
@property (nonatomic, copy)void (^ClickItemOperation)();

/** 枚举 */
@property (nonatomic, assign)CellItemType type;

@end
