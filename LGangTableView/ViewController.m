//
//  ViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/15.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "ViewController.h"
#import "LGTableObject.h"
#import "NomalTableViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface ViewController ()


@property (nonatomic, strong) LGTableObject *lgTableObject;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"示例Demo";
    //设置tableView的headerView
//    UIView *headView = [UIView new];
//    headView.backgroundColor = [UIColor lightGrayColor];
//    headView.frame = CGRectMake(0, 0, 100, 80);
//    self.lgTableObject.tableView.tableHeaderView = headView;
    
    //刷新
    self.lgTableObject.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.lgTableObject.dataSource(@[@"123",@"345"]);
        [self.lgTableObject.tableView.mj_header endRefreshing];
    }];
    
    self.lgTableObject.frame(self.view.bounds).parentView(self.view).rowHeight(50).separatorStyle(UITableViewCellSeparatorStyleSingleLine).dataSource(self.datas).setCellForRow(^(UITableViewCell *  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = model;
    }).setDidSelectRow(^(id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
         UIViewController *viewController = [NSClassFromString(self.viewControllers[indexPath.row]) new];
//        NomalTableViewController *viewController = [NomalTableViewController new];
               viewController.title = self.datas[indexPath.row];
               [self.navigationController pushViewController:viewController animated:YES];
    });
    
    // Do any additional setup after loading the view.
}



#pragma  mark --------------------------- 懒加载 --------------------------
- (NSArray *)datas {
    if (_datas == nil) {
        _datas = @[@"链式调用",@"继承式扩展",@"cell 高度自适应",@"tableView 分组"];
    }
    return _datas;
}
- (NSArray *)viewControllers {
    if (_viewControllers == nil) {
        _viewControllers = @[@"NomalTableViewController",@"CustemViewController",@"LGCellAutoViewController",@"LGTableGroupViewController"];
    }
    return _viewControllers;
}
-(LGTableObject *)lgTableObject{
    if (!_lgTableObject) {
        _lgTableObject = [LGTableObject adapterCellsWithCellClass:@[[UITableViewCell class]] style:UITableViewStylePlain];
    }
    return _lgTableObject;
}

@end
