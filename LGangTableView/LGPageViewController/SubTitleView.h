//
//  SubTitleView.h
//  LGangTableView
//
//
//  Created by liugang on 2020/10/27.
//  Copyright © 2020 mibo02. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SubTitleConfig.h"
@class SubTitleView;

@protocol SubTitleViewDelegate <NSObject>

- (void)findSubTitleViewDidSelected:(SubTitleView *)titleView atIndex:(NSInteger )index title:(NSString *)title;

@end


@interface SubTitleView : UIView

//字标题视图的数据源
@property (nonatomic, strong)NSMutableArray <NSString *> *titleArray;
@property (nonatomic, weak) __weak id<SubTitleViewDelegate> delegate;

- (void) configSubTitleWith:(SubTitleConfig *)config;

- (void)trans2ShowAtIndex:(NSInteger)index;

@end
