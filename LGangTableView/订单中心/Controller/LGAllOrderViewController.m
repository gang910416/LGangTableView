//
//  LGAllOrderViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/27.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGAllOrderViewController.h"
#import "OrderListModel.h"
#import "LGTableViewManager.h"
#import "LQOrderTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
@interface LGAllOrderViewController ()
@property (nonatomic, strong) NSArray *orderDatas;
@property (nonatomic, strong) LGTableViewManager *tableObject;
@end

@implementation LGAllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单中心";
    //刷新
    self.tableObject.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.tableObject.dataSource(self.orderDatas);
        [self.tableObject.tableView.mj_header endRefreshing];
    }];
    self.tableObject.frame(self.view.bounds).parentView(self.view).dataSource(self.orderDatas).separatorStyle(UITableViewCellSeparatorStyleSingleLine).setDidSelectRow(^(OrderListModel *model, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"model.title = %@",model.title);
        
    });
}
- (NSArray *)orderDatas{
    if (_orderDatas == nil) {
        
        OrderListModel *model1 = [OrderListModel new];
        model1.title = @"她只喜欢詹姆斯！";
        model1.time = @"2020/10/16 06:30";
        model1.goodsId = 1;
        
        OrderListModel *model2 = [OrderListModel new];
        model2.title = @"火箭队总经理莫雷辞职";
        model2.time = @"2020/10/16 00:19 ";
        model2.goodsId = 1;
        
        OrderListModel *model3 = [OrderListModel new];
        model3.title = @"湖人总冠军";
        model3.time = @"2020/10/16 06:30";
        model3.goodsId = 1;
        
        OrderListModel *model4 = [OrderListModel new];
        model4.title = @"她只喜欢詹姆斯！";
        model4.time = @"2020/10/16 06:30";
        model4.goodsId = 1;
        
        OrderListModel *model5 = [OrderListModel new];
        model5.title = @"火箭队总经理莫雷辞职";
        model5.time = @"2020/10/16 00:19 ";
        model5.goodsId = 1;
        
        OrderListModel *model6 = [OrderListModel new];
        model6.title = @"湖人总冠军";
        model6.time = @"2020/10/16 06:30";
        model6.goodsId = 1;
       
    
        _orderDatas = @[model1,model2,model3,model4,model5,model6];
    }
    return _orderDatas;
}

-(LGTableViewManager *)tableObject{
    if (!_tableObject) {
        _tableObject = LGTableViewManager.adapter(@[[LQOrderTableViewCell class]]);
    }
    return _tableObject;
}


@end
