//
//  LGTableObject.m
//  LGangTableView
//
//  Created by liugang on 2020/10/15.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGTableObject.h"

static NSString *prefix = @"LGCellId";

@interface LGTableObject ()
//cell标识符前缀

@property (nonatomic, copy, readwrite) NSString *cellProps;

@end

@implementation LGTableObject

+ (LGTableObject *)adapterCellsWithCellClass:(NSArray<Class> *)cellsClass style:(UITableViewStyle)style{
    UITableView *tableview = [self getTableView:style];
    return [self adapterWithTableView:tableview cellsClass:cellsClass];
}

+ (LGTableObject *)adapterWithTableView:(UITableView *)tableView  cellsClass:(NSArray<Class> *)cellsClass{
    
    NSAssert([tableView isKindOfClass:[UITableView class]], @"tableView 必须是UITableView的子类");

       LGTableObject *adapter = [self new];
       adapter.sectionCount = 1;

       tableView.delegate = adapter;
       tableView.dataSource = adapter;

       adapter.tableView = tableView;
       
       [adapter registCell:cellsClass];
       return adapter;
}

//注册cell

- (void)registCell:(NSArray<Class> *)cellsClass {
    NSMutableArray *cellIds = [@[] mutableCopy];
       for (Class cellClass in cellsClass) {
            NSAssert([cellClass isSubclassOfClass:[UITableViewCell class]], @"cellClass 必须是UITableViewCell的子类");
             NSString *className = NSStringFromClass(cellClass);
             NSString *cellReuseIdentifier = [NSString stringWithFormat:@"%@_%@", prefix, className];
           [cellIds addObject:cellReuseIdentifier];
             NSString *nibPath = [[NSBundle mainBundle]pathForResource:className ofType:@"nib"];
             if (nibPath) { //当前cell是xib
                 [self.tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
             } else { //当前cell不是xib
                 [self.tableView registerClass:cellClass forCellReuseIdentifier:cellReuseIdentifier];
             }
       }
       self.cellReuseIdentifiers = [cellIds copy];

}

+ (LGTableObject *_Nonnull(^)(NSArray<Class>  * cellsClass))adapter{
    return ^LGTableObject *(NSArray<NSString *> *cellsClassName) {
          NSMutableArray *classes = [@[] mutableCopy];
          for(int index = 0;index < cellsClassName.count;index++){
              [classes addObject:NSClassFromString(cellsClassName[index])];
           }
          return [self adapterCellsWithCellClass:[classes copy] style:UITableViewStyleGrouped];
     };
}

+ (LGTableObject *_Nonnull(^)(NSArray<NSString *> *cellsClassName))adapterWithCellsName{
    return ^LGTableObject *(NSArray<Class>  * cellsClass) {
      return [self adapterCellsWithCellClass:cellsClass style:UITableViewStyleGrouped];
    };

}

//设置tableView的frame
- (TableViewFrameBlock)frame{
    return ^LGTableObject *(CGRect frame){
        self.tableView.frame = frame;
        return self;
    };
}
//设置tableView的父控件
- (ParentViewBlock)parentView{
   
    return ^LGTableObject *(UIView *parentView){
        [parentView addSubview:self.tableView];
        return self;
    };
}

// 设置分割线类型
- (CellSeparationStyleBlock)separatorStyle{
    return ^LGTableObject *(UITableViewCellSeparatorStyle separatorStyle){
        self.tableView.separatorStyle = separatorStyle;
        return self;
    };
}

// 设置row 的高度
- (TableViewRowHeightBlock)rowHeight{
    return ^LGTableObject *(CGFloat rowHeight){
        self.tableView.rowHeight = rowHeight;
        return self;
    };
}

- (TableViewSectionCountBlock)count{
    return ^LGTableObject * (NSInteger sectionCount){
        self.sectionCount = sectionCount;
        return self;
    };
}

- (TableViewDatasBlock)dataSource{
    return ^LGTableObject *(NSArray *dataSource){
        self.tableViewDatas = dataSource;
        return self;
    };
}
//获取section count
- (NSArray *)getSectionDataSource:(NSInteger)section {
    if (self.sectionCount > 1 && self.tableViewDatas.count == self.sectionCount) { //多个区
        NSArray *sectionDatas = self.tableViewDatas[section];
        return sectionDatas;
    }else{
        return self.tableViewDatas;
    }
}

- (CellPropertyBlock)cellProperty{
    return ^LGTableObject *(NSString *cellProperty){
          if (cellProperty && cellProperty.length > 0) {
              cellProperty = [cellProperty stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
          }
           self.cellProps = cellProperty;
           return self;
       };
}

- (SetSelectCellBlock)setSelectCell{
    return ^LGTableObject *(SelectCellBlock selectCell){
        self.selectCellBlock = selectCell;
        return self;
    };
}

- (SetCellForRowBlock)setCellForRow{
      return ^LGTableObject *(TableViewCellForRowBlock cellForRow){
          self.cellForRow = cellForRow;
          return self;
      };
}

- (SetDidSelectRowBlock)setDidSelectRow{
    return ^LGTableObject *(TableViewDidSelectedRowBlock didSelectRow){
        self.didSelectRow = didSelectRow;
        return self;
    };
}
#pragma mark -- public
- (void)reloadData {
    [self.tableView reloadData];
}
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

//创建tableView
+ (UITableView *)getTableView:(UITableViewStyle)style {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:style];
       tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
       //当没有cell时去掉分界线
       tableView.tableFooterView = [UIView new];
       
       //兼容iOS11以后的系统在Grouped tableView上移
       UIView *tableHeaderView = [UIView new];
       tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
       tableView.tableHeaderView = tableHeaderView;
       
       //为了防止iOS11 sectionHead和sectionFooter 回调方法不执行
       tableView.sectionHeaderHeight = 0.01;
       tableView.sectionFooterHeight = 0.01;
       
       return tableView;
}

- (void)setTableViewDatas:(NSArray *)tableViewDatas{
    self.tableViewDatas = tableViewDatas;
    [self.tableView reloadData];
}
@end
