//
//  LQOrderCenterViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/26.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LQOrderCenterViewController.h"
#import "LGPageViewController.h"
#import "Masonry.h"
#import "SubTitleConfig.h"
@interface LQOrderCenterViewController ()

@property (nonatomic, strong)NSMutableArray *subTitleArray;
@property (nonatomic, strong)NSMutableArray *childVCName;
@property (nonatomic , strong) LGPageViewController *pageVC;
@end

@implementation LQOrderCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"订单中心";
    SubTitleConfig *config = [[SubTitleConfig alloc]init];
    config.titleArray = self.subTitleArray;
    config.fontSize = 14.0;
    config.sel_fontSize = 18.0;
    config.nomalColor = UIColor.grayColor;
    config.selectedColor = UIColor.redColor;
    config.siderWith = 60;
    
    self.pageVC = [[LGPageViewController alloc]initWithTitleSubTitleConfig:config controllers:self.childVCName];
     [self addChildViewController:self.pageVC];
     [self.view addSubview:self.pageVC.view];
 //    self.subTitleView.titleArray = self.subTitleArray;
     [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.view.mas_top).offset(100);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
}

/**
 *  分类标题数组
 */
- (NSMutableArray *)subTitleArray {
    if(!_subTitleArray) {
        _subTitleArray = [[NSMutableArray alloc] initWithObjects:@"全部订单",@"待支付",@"待收货",@"已完成",@"待评价",@"售后订单",nil];
    }
    return _subTitleArray;
}

- (NSMutableArray *)childVCName {
    if(!_childVCName) {
        _childVCName = [[NSMutableArray alloc] initWithObjects:@"LGAllOrderViewController",@"LQDZhiFuViewController",@"LGAllOrderViewController",@"LQDZhiFuViewController",@"LGAllOrderViewController",@"LQDZhiFuViewController",nil];
    }
    return _childVCName;
}



@end
