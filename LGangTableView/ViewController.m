//
//  ViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/15.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "ViewController.h"
#import "LGTableViewManager.h"
#import "NomalTableViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface ViewController ()


@property (nonatomic, strong) LGTableViewManager *tableManager;

@property (nonatomic, strong) NSMutableArray *datas;

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
    self.tableManager.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.datas addObject:@"NBA 状元"];
//        [self.datas addObject:@"NBA 状元"];
//        [self.datas addObject:@"NBA 状元"];
//        self.tableManager.dataSource(self.datas);
        [self.tableManager.tableView.mj_header endRefreshing];
    }];
    self.tableManager.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.datas removeLastObject];
        self.tableManager.dataSource(self.datas);
        [self.tableManager.tableView.mj_footer endRefreshing];
    }];
    
   
    
    self.tableManager.frame(self.view.bounds).parentView(self.view).rowHeight(50).separatorStyle(UITableViewCellSeparatorStyleSingleLine).dataSource(self.datas).setCellForRow(^(UITableViewCell *  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
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
- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithObjects:@"链式调用",@"继承式扩展",@"cell 高度自适应",@"tableView 分组", @"常见的控件封装",@"基础点",nil];
    }
    return _datas;
}
- (NSArray *)viewControllers {
    if (_viewControllers == nil) {
        _viewControllers = @[@"NomalTableViewController",@"CustemViewController",@"LGCellAutoViewController",@"LGTableGroupViewController",@"CustemViewC",@"LGPointViewcontroller"];
    }
    return _viewControllers;
}
-(LGTableViewManager *)tableManager{
    if (!_tableManager) {
        _tableManager = [LGTableViewManager adapterCellsWithCellClass:@[[UITableViewCell class]] style:UITableViewStylePlain];
    }
    return _tableManager;
}

@end
