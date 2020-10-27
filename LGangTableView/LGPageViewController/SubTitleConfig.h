//
//  SubTitleConfig.h
//  LGangTableView
//
//  Created by liugang on 2020/10/27.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SubTitleConfig : NSObject
// title
@property (nonatomic, strong) NSMutableArray <NSString *> *titleArray;
@property (nonatomic, assign) CGFloat height;// 导航的高度
@property (nonatomic, assign) CGFloat siderWith;// 底部先的宽度
@property (nonatomic, strong) UIColor *nomalColor; // 导航 按钮默认颜色
@property (nonatomic, strong) UIColor *selectedColor; // 导航 按钮选中颜色
@property (nonatomic, assign) CGFloat fontSize; // 导航的按钮字体大小
@property (nonatomic, assign) CGFloat sel_fontSize; // 导航的按钮选中字体大小

@end

NS_ASSUME_NONNULL_END
