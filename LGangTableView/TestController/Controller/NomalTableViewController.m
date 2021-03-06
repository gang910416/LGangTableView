//
//  NomalTableViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "NomalTableViewController.h"
#import "LGTableViewManager.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"

@interface NomalTableViewController ()
@property (nonatomic, strong) LGTableViewManager *tableObject;

@property (nonatomic, strong) NSArray *datas;
@end

@implementation NomalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    //第一种
//    self.tableObject.frame(self.view.bounds).parentView(self.view).separatorStyle(UITableViewCellSeparatorStyleSingleLine).rowHeight(60).dataSource(self.datas).setDidSelectRow(^(NewsModel *  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
//        NSLog(@"------%@",model.title);
//    });
    //第二种
    self.tableObject.frame(self.view.bounds).parentView(self.view).separatorStyle(UITableViewCellSeparatorStyleSingleLine).rowHeight(60).dataSource(self.datas).setDidSelectRow(^(NewsModel *  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"------%@",model.title);
    }).setCellForRow(^(NewsTableViewCell * _Nonnull cell, NewsModel*  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"model = %@ indexPath = %ld",model.title,indexPath.row);

        [cell cellConfigModel:model];
        
    });

    // Do any additional setup after loading the view.
}

- (NSArray *)datas{
    if (_datas == nil) {
        
        NewsModel *model1 = [NewsModel new];
        model1.title = @"她只喜欢詹姆斯！";
        model1.time = @"2020/10/16 06:30";
        model1.content = @"我是勒布朗球迷！一直都是！谢谢你，拜拜！";
        
        NewsModel *model2 = [NewsModel new];
        model2.title = @"火箭队总经理莫雷辞职";
        model2.time = @"2020/10/16 00:19 ";
        model2.content = @"莫雷向球队老板费蒂尔塔提出了辞职的想法。";
        
        NewsModel *model3 = [NewsModel new];
        model3.title = @"湖人总冠军";
        model3.time = @"2020/10/16 06:30";
        model3.content = @"湖人再一次多的NBA总冠军。";
        
        _datas = @[model1,model2,model3];
    }
    return _datas;
}

-(LGTableViewManager *)tableObject{
    if (!_tableObject) {
        _tableObject = LGTableViewManager.adapter(@[[NewsTableViewCell class]]);
    }
    return _tableObject;
}

@end
