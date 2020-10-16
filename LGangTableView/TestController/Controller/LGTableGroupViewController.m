//
//  LGTableGroupViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGTableGroupViewController.h"
#import "LGTableObject.h"
#import "Mnustil.h"
@interface LGTableGroupViewController ()

@property (nonatomic, strong) LGTableObject *lgTableObject;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation LGTableGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.lgTableObject.frame(self.view.bounds).parentView(self.view).rowHeight(50).separatorStyle(UITableViewCellSeparatorStyleSingleLine).count(self.datas.count).dataSource(self.datas).setCellForRow(^(UITableViewCell *  _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = model;
        
        if (indexPath.section == self.datas.count - 1) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [Mnustil colorWithHexString:@"FF9393"];
        }
    });
    // Do any additional setup after loading the view.
}

- (NSArray *)datas {
    if (_datas == nil) {
        _datas = @[@[@"意见反馈",@"关于我们",@"版本信息",@"清除缓存"],@[@"修改密码"],@[@"退出登录"]];
    }
    return _datas;
}

-(LGTableObject *)lgTableObject{
    if (!_lgTableObject) {
        _lgTableObject = [LGTableObject adapterCellsWithCellClass:@[[UITableViewCell class]] style:UITableViewStyleGrouped];
    }
    return _lgTableObject;
}


@end
