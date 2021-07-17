//
//  LGTableGroupViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGTableGroupViewController.h"
#import "LGTableViewManager.h"
#import "Mnustil.h"

#import "LQOrderCenterViewController.h"
@interface LGTableGroupViewController ()

@property (nonatomic, strong) LGTableViewManager *tableManager;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation LGTableGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.tableManager.frame(self.view.bounds).parentView(self.view).rowHeight(50).separatorStyle(UITableViewCellSeparatorStyleSingleLine).sectionsCount(self.datas.count).dataSource(self.datas).setCellForRow(^(UITableViewCell *  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = model;

        if (indexPath.section == self.datas.count - 1) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [Mnustil colorWithHexString:@"FF9393"];
        }
    }).setDidSelectRow(^(id _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        if (indexPath.row == 0) {
            LQOrderCenterViewController *vc = [LQOrderCenterViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    });
    // Do any additional setup after loading the view.
}

- (NSArray *)datas {
    if (_datas == nil) {
        _datas = @[@[@"订单中心",@"关于我们"],@[@"版本信息",@"清除缓存"],@[@"修改密码",@"我的钱包",@"地址管理"],@[@"退出登录"]];
    }
    return _datas;
}


-(LGTableViewManager *)tableManager{
    if (!_tableManager) {
        _tableManager = [LGTableViewManager adapterCellsWithCellClass:@[[UITableViewCell class]] style:UITableViewStyleGrouped];
    }
    return _tableManager;
}


@end
