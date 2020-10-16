//
//  CustemViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "CustemViewController.h"
#import "NewsTableAdapter.h"
#import "PersonModel.h"
@interface CustemViewController ()

@property (nonatomic, strong) NewsTableAdapter *tableObjiect;

@property (nonatomic, strong) NSArray *datas;
@end

@implementation CustemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableObjiect.frame(self.view.bounds).parentView(self.view).separatorStyle(UITableViewCellSeparatorStyleSingleLine)
              .rowHeight(80)
    .count(self.datas.count)
    .dataSource(self.datas);
    // Do any additional setup after loading the view.
}

#pragma mark -- getter
- (NSArray *)datas {
    if (_datas == nil) {
        PersonModel *p1 = [PersonModel new];
        p1.name = @"吴京";
        p1.age = 48;
        p1.hobby = @"练武，演戏";
         p1.info = @"一个来自北京的导演";
        
        PersonModel *p2 = [PersonModel new];
        p2.name = @"詹姆斯";
        p2.age = 35;
        p2.hobby = @"篮球";
        p2.info = @"当今联盟第一人";
        
        PersonModel *p3 = [PersonModel new];
        p3.name = @"朱元璋";
        p3.age = 53;
        p3.hobby = @"爱江山更爱美人";
        p3.info = @"大明朝开国皇帝";
        
        _datas = @[@[p1],@[p2],@[p3]];
        
    }
   return _datas;
}

- (NewsTableAdapter *)tableObjiect {
    if (_tableObjiect == nil) {
        //三种创建方式 效果一样 喜欢哪一种自己选择 自动支持xib
        _tableObjiect = (NewsTableAdapter *)NewsTableAdapter.adapterWithCellsName(@[@"ExtendCell"]);
    }
   return _tableObjiect;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
