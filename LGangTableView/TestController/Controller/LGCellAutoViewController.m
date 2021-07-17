//
//  LGCellAutoViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGCellAutoViewController.h"
#import "LGTableViewManager.h"
#import "CellAutoTableViewCell.h"
#import "CellAutosModel.h"
@interface LGCellAutoViewController ()

@property (nonatomic, strong) LGTableViewManager *lgTableObject;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation LGCellAutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.lgTableObject.frame(self.view.bounds).parentView(self.view).separatorStyle(UITableViewCellSeparatorStyleSingleLine).dataSource(self.datas).setDidSelectRow(^(CellAutosModel *model, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"%@",model.title);
    });
    // Do any additional setup after loading the view.
}

- (NSArray *)datas{
    if (_datas == nil) {
        
        CellAutosModel *model1 = [CellAutosModel new];
        model1.title = @"她只喜欢詹姆斯！";
        model1.content = @"我是勒布朗球迷！一直都是！谢谢你，拜拜！我是勒布朗球迷！一直都是！谢谢你，拜拜！我是勒布朗球迷！一直都是！谢谢你，拜拜！我是勒布朗球迷！一直都是！谢谢你，拜拜！我是勒布朗球迷！一直都是！谢谢你，拜拜！";
        
        CellAutosModel *model2 = [CellAutosModel new];
        model2.title = @"老詹调侃总冠军奖杯不忠诚:过去5年都在搞外遇老詹调侃总冠军奖杯不忠诚:过去5年都在搞外遇";
        model2.content = @"在视频中，詹姆斯一边抱着拉里-奥布莱恩杯一边说道：“我都不敢相信你过去五年都在背着我搞外遇。”当这段视频流出的时候，这也让很多球迷都哭笑不得，不少球迷调侃称：“老詹这是在卖萌吗？”值得一提的是，2019-20赛季，詹姆斯荣膺总决赛MVP，这也是他的第四座总决赛MVP。上一次，詹姆斯捧得总冠军奖杯还要追溯到2016年。算上今年，刚好是5年之后，詹姆斯再次获得了总冠军";
        CellAutosModel *model3 = [CellAutosModel new];
        model3.title = @"湖人总冠军";
        model3.content = @"湖人再一次多的NBA总冠军。";
        _datas = @[model1,model2,model3];
    }
    return _datas;
}


-(LGTableViewManager *)lgTableObject{
    if (!_lgTableObject) {
        _lgTableObject = LGTableViewManager.adapter(@[[CellAutoTableViewCell class]]);
    }
    return _lgTableObject;
}
@end
