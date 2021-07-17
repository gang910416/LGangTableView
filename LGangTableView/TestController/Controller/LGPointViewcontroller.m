//
//  LGPointViewcontroller.m
//  LGangTableView
//
//  Created by liugang on 2021/7/16.
//  Copyright © 2021 liugang. All rights reserved.
//

#import "LGPointViewcontroller.h"
#import "LGTableViewManager.h"
#import "PointTableViewCell.h"
#import "AlterViewController.h"

@interface LGPointViewcontroller ()

@property (nonatomic, strong) LGTableViewManager *tableView;
@property (nonatomic,strong) NSMutableArray *datas;

@end

@implementation LGPointViewcontroller

int  a = 6;

- (void)viewDidLoad {
    [super viewDidLoad];
    //如果block中是普通的局部变量，是值传递，即在局部变量声明的那一刻就把局部变量的值放到block中了，之后在修改不会造成影响
//    * 如果是静态变量,全局变量,__block修饰的变量,block都是指针传递。指针传递的值可以修改。
//    如果block中是普通的局部变量，是值传递，即在局部变量声明的那一刻就把局部变量的值放到block中了，之后在修改不会造成影响
//    * 如果是静态变量,全局变量,__block修饰的变量,block都是指针传递。指针传递的值可以修改。
//   static int  a = 3;//静态变量
    int  a = 3;//普通变量
    void(^block)(void) = ^{
        NSLog(@"a = %d",a);
    };
    a = 5;

    self.view.backgroundColor = UIColor.whiteColor;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 150)];
    view.backgroundColor = UIColor.redColor;
//    self.tableView.headerView(view);q
    self.tableView.frame(self.view.bounds).parentView(self.view).rowHeight(50).dataSource(self.datas).separatorStyle(UITableViewCellSeparatorStyleSingleLine).setCellForRow(^(PointTableViewCell * _Nonnull cell, id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = model;
        
        cell.pointBlock = ^(NSString * _Nonnull string) {
            __block  int multiplier = 6;
                int(^Block)(int) = ^int(int num){
                    
                    return  num * multiplier;
                };
                multiplier = 4;
                NSLog(@" --  %d ---- ",Block(2));
            
            AlterViewController *vc = [[AlterViewController alloc]init];
            vc.view.backgroundColor = [UIColor brownColor];
            vc.dismissBlock = ^(NSString * _Nonnull value) {
                NSLog(@"value = %@",value);
            };
            
            [self presentViewController:vc animated:YES completion:nil];
            
        };
        
    }).setDidSelectRow(^(id  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        block();
        int age = 1;
        void (^block1)(void) = ^{
            NSLog(@"block1");
        };

        void (^block2)(void) = ^{
            NSLog(@"block2:%d",age);
        };

        NSLog(@"%@/%@/%@",[block1 class],[block2 class],[^{
            NSLog(@"block3:%d",age);
        } class]);
    });
    // Do any additional setup after loading the view.
}


- (LGTableViewManager *)tableView{
    if (!_tableView) {
        _tableView  =[LGTableViewManager adapterCellsWithCellClass:@[[PointTableViewCell class]] style:UITableViewStylePlain];
    }
    return  _tableView;
}
- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithObjects:@"Block 相关",@"代理相关",nil];
    }
    return _datas;
}
@end


