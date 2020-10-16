//
//  NomalTableViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "NomalTableViewController.h"
#import "LGTableObject.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
@interface NomalTableViewController ()
@property (nonatomic, strong) LGTableObject *tableObject;

@property (nonatomic, strong) NSArray *datas;
@end

@implementation NomalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.tableObject.frame(self.view.bounds).parentView(self.view).separatorStyle(UITableViewCellSeparatorStyleSingleLine).dataSource(self.datas).setDidSelectRow(^(NewsModel *  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"------%@",model.title);
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
        model2.content = @"莫雷向球队老板费蒂尔塔提出了辞职的想法，随后双方在不公开的情况下达成一致。";
        NewsModel *model3 = [NewsModel new];
               model3.title = @"2016年的詹姆斯对比2020年的詹姆斯";
               model3.time = @"2020/10/16 06:30";
               model3.content = @"2016年总决赛，詹姆斯场均29.7分11.3篮板8.9助攻，投篮命中率49.4%，三分命中率37.1%，罚球命中率72.1%。2020年总决赛，詹姆斯场均29.8分11.8篮板8.5助攻，投篮命中率58.6%，三分命中率39.0%，罚球命中率66.7%";
        _datas = @[model1,model2,model3];
    }
    return _datas;
}

-(LGTableObject *)tableObject{
    if (!_tableObject) {
        _tableObject = LGTableObject.adapter(@[[NewsTableViewCell class]]);
    }
    return _tableObject;
}

@end
