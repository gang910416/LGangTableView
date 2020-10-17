//
//  LGTableObject.m
//  LGangTableView
//
//  Created by liugang on 2020/10/15.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGTableViewManager.h"
#import "LGBaseModel.h"
static NSString *prefix = @"LGCellId";

@interface LGTableViewManager ()
//cell标识符前缀
@property (nonatomic, copy) NSString *cellProps;
@property (nonatomic, assign) CGFloat rowsHeight;
@end

@implementation LGTableViewManager

+ (LGTableViewManager *)adapterCellsWithCellClass:(NSArray<Class> *)cellsClass style:(UITableViewStyle)style{
    UITableView *tableview = [self getTableView:style];
    return [self adapterWithTableView:tableview cellsClass:cellsClass];
}

+ (LGTableViewManager *)adapterWithTableView:(UITableView *)tableView  cellsClass:(NSArray<Class> *)cellsClass{
    
    NSAssert([tableView isKindOfClass:[UITableView class]], @"tableView 必须是UITableView的子类");
    
    LGTableViewManager *adapter = [self new];
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

+ (LGTableViewManager *_Nonnull(^)(NSArray<Class>  * cellsClass))adapter{
    return ^LGTableViewManager *(NSArray<Class>  * cellsClass) {
        return [self adapterCellsWithCellClass:cellsClass style:UITableViewStyleGrouped];
    };
}

+ (LGTableViewManager *_Nonnull(^)(NSArray<NSString *> *cellsClassName))adapterWithCellsName{
    return ^LGTableViewManager *(NSArray<NSString *> *cellsClassName) {
        NSMutableArray *classes = [@[] mutableCopy];
        for(int index = 0;index < cellsClassName.count;index++){
            [classes addObject:NSClassFromString(cellsClassName[index])];
        }
        return [self adapterCellsWithCellClass:[classes copy] style:UITableViewStyleGrouped];
    };
    
}

#pragma mark ---UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.rowsHeight > 0) {
        return self.rowsHeight;
    }else{
        return UITableViewAutomaticDimension;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self getSectionDataSource:section] ;
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self getSectionDataSource:indexPath.section][indexPath.row];
    NSString *cellid = self.cellReuseIdentifiers.firstObject;
    if (self.selectCellBlock) {
        NSInteger index = self.selectCellBlock();
        cellid = self.cellReuseIdentifiers[index];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    NSString *methodName = [NSString stringWithFormat:@"%@%@:",@"set",[model class]];
    if (self.cellProps != nil && self.cellProps.length != 0) {
        methodName = [NSString stringWithFormat:@"set%@:",[self.cellProps capitalizedString]];
    }
    if (self.cellForRow == nil && [cell respondsToSelector:NSSelectorFromString(methodName)]) { //查看cell是否有model属性，有则赋予值
        [cell setValue:model forKey:[NSString stringWithFormat:@"%@",[model class]]];
    }
    if (self.cellForRow) {
        self.cellForRow(cell,model,indexPath);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id model = [self getSectionDataSource:indexPath.section][indexPath.row];
    if (self.didSelectRow) {
        self.didSelectRow(model,indexPath);
    }
}


//设置tableView的frame
- (TableViewFrameBlock)frame{
    return ^LGTableViewManager *(CGRect frame){
        self.tableView.frame = frame;
        return self;
    };
}
//设置tableView的父控件
- (ParentViewBlock)parentView{
    
    return ^LGTableViewManager *(UIView *parentView){
        [parentView addSubview:self.tableView];
        return self;
    };
}

// 设置分割线类型
- (CellSeparationStyleBlock)separatorStyle{
    return ^LGTableViewManager *(UITableViewCellSeparatorStyle separatorStyle){
        self.tableView.separatorStyle = separatorStyle;
        return self;
    };
}

// 设置row 的高度
- (TableViewRowHeightBlock)rowHeight{
    return ^LGTableViewManager *(CGFloat rowHeight){
        self.rowsHeight = rowHeight;
        return self;
    };
}

- (TableViewSectionCountBlock)count{
    return ^LGTableViewManager * (NSInteger sectionCount){
        self.sectionCount = sectionCount;
        return self;
    };
}

- (TableViewDatasBlock)dataSource{
    return ^LGTableViewManager *(NSArray *dataSource){
        self.tableViewDatas = dataSource;
        [self.tableView reloadData];
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
    return ^LGTableViewManager *(NSString *cellProperty){
        if (cellProperty && cellProperty.length > 0) {
            cellProperty = [cellProperty stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        }
        self.cellProps = cellProperty;
        return self;
    };
}

- (SetSelectCellBlock)setSelectCell{
    return ^LGTableViewManager *(SelectCellBlock selectCell){
        self.selectCellBlock = selectCell;
        return self;
    };
}

- (SetCellForRowBlock)setCellForRow{
    return ^LGTableViewManager *(TableViewCellForRowBlock cellForRow){
        self.cellForRow = cellForRow;
        return self;
    };
}

- (SetDidSelectRowBlock)setDidSelectRow{
    return ^LGTableViewManager *(TableViewDidSelectedRowBlock didSelectRow){
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
//    
//    tableView.sectionHeaderHeight = 0.01;
//    tableView.sectionFooterHeight = 0.01;
    tableView.estimatedRowHeight = 60.0;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    return tableView;
}

//- (void)setTableViewDatas:(NSArray *)tableViewDatas{
//    self.tableViewDatas = tableViewDatas;
//    [self.tableView reloadData];
//}
@end
