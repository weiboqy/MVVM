//
//  CellItemSectionModel.h
//  MVVM
//
//  Created by lanou on 16/4/28.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellItemSectionModel : NSObject

@property (nonatomic, strong)NSArray *itemArray;
@property (nonatomic, copy)NSString *sectionName;
@property (nonatomic, assign)CGFloat sectionHeaderHeight;

@end
