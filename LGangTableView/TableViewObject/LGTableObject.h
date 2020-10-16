//
//  LGTableObject.h
//  LGangTableView
//
//  Created by liugang on 2020/10/15.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGTableObject : NSObject<UITableViewDelegate,UITableViewDataSource>

// cell 设置block
typedef void(^TableViewCellForRowBlock)(id cell ,id model, NSIndexPath *indexPath);
//cell 点击
typedef void(^TableViewDidSelectedRowBlock)(id model,NSIndexPath *indexPath);

typedef NSInteger(^SelectCellBlock)(void);

//tableView 的 frame
typedef LGTableObject *_Nonnull(^TableViewFrameBlock)(CGRect frame);

// tableView 的 父控件
typedef LGTableObject *_Nullable(^ParentViewBlock)(UIView *parentView);

// tableView 的section  数量
typedef LGTableObject *_Nullable(^TableViewSectionCountBlock)(NSInteger sectionCount);

// row 的高度
typedef LGTableObject *_Nullable(^TableViewRowHeightBlock)(CGFloat rowHeight);

// tableView 分割线样式
typedef LGTableObject *_Nullable(^CellSeparationStyleBlock)(UITableViewCellSeparatorStyle separatorStyle);
// tableView 的数据源
typedef LGTableObject *_Nonnull(^TableViewDatasBlock)(NSArray *dataSource);

typedef LGTableObject *_Nonnull(^SetCellForRowBlock)(TableViewCellForRowBlock cellForRow);

typedef LGTableObject *_Nonnull(^SetSelectCellBlock)(SelectCellBlock selectCell);
typedef LGTableObject *_Nonnull(^CellPropertyBlock)(NSString *cellProperty);
typedef LGTableObject *_Nonnull(^SetDidSelectRowBlock)(TableViewDidSelectedRowBlock didSelectRow);


//设置tableView大小 默认是 CGRectZero
@property (nonatomic, copy, readonly) TableViewFrameBlock frame;
//设置tableView父View
@property (nonatomic, copy, readonly) ParentViewBlock parentView;
//设置分界线 默认不显示
@property (nonatomic, assign, readonly) CellSeparationStyleBlock separatorStyle;
//设置tableView rowHeight
@property (nonatomic, assign, readonly) TableViewRowHeightBlock rowHeight;

//设置section 的数量
@property (nonatomic, copy, readonly) TableViewSectionCountBlock count;

//设置数据 自动触发刷新tableView
@property (nonatomic, copy, readonly) TableViewDatasBlock dataSource;

//用于自动给cell传值，如果cellForRow设置过 或 调用setCellForRow,则此设置无效
//如果不设置默认为 model
@property (nonatomic, copy, readonly) CellPropertyBlock cellProperty;

//针对多种类型的cell，必传
@property (nonatomic, copy, readonly) SetSelectCellBlock setSelectCell;

@property (nonatomic, copy) SelectCellBlock selectCellBlock;

//设置cellForRow回调
@property (nonatomic, copy, readonly) SetCellForRowBlock setCellForRow;
//设置点击cell回调
@property (nonatomic, copy, readonly) SetDidSelectRowBlock setDidSelectRow;

//cell标识符为 eden_类名
@property (nonatomic, strong) NSArray *cellReuseIdentifiers;

//tableView
@property (nonatomic, strong) UITableView *tableView;
//数据源 ---- section 个数 默认为1
@property (nonatomic, assign) NSInteger sectionCount;

//会自动触发刷新tableView
@property (nonatomic, strong) NSArray *tableViewDatas;
//cell forrow
@property (nonatomic, copy) TableViewCellForRowBlock cellForRow;

//cellforrow
@property (nonatomic, copy) TableViewDidSelectedRowBlock didSelectRow;


//刷新页面 不建议使用
- (void)reloadData;

//刷新指定列表
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

// 初始化tableView 注册cell
+ (LGTableObject *)adapterCellsWithCellClass:(NSArray<Class> *)cellsClass style:(UITableViewStyle)style;

//链式设置属性
//用链式调用创建适配器(用属性的方式)
+ (LGTableObject *_Nonnull(^)(NSArray<Class>  * cellsClass))adapter;

+ (LGTableObject *_Nonnull(^)(NSArray<NSString *> *cellsClassName))adapterWithCellsName;


@end

NS_ASSUME_NONNULL_END
