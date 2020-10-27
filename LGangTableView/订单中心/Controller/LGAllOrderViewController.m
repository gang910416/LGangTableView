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

@interface LGAllOrderViewController ()
@property (nonatomic, strong) NSArray *orderDatas;
@property (nonatomic, strong) LGTableViewManager *tableObject;
@end

@implementation LGAllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单中心";
    self.tableObject.frame(self.view.bounds).parentView(self.view).dataSource(self.orderDatas).separatorStyle(UITableViewCellSeparatorStyleSingleLine).setDidSelectRow(^(OrderListModel *model, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"model.title = %@",model.title);
        
    });
    
    
    // Do any additional setup after loading the view.
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
        _orderDatas = @[model1,model2,model3];
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
