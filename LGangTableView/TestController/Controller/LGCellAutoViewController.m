//
//  LGCellAutoViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGCellAutoViewController.h"
#import "LGTableObject.h"
@interface LGCellAutoViewController ()

@property (nonatomic, strong) LGTableObject *lgTableObject;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation LGCellAutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
}

-(LGTableObject *)lgTableObject{
    if (!_lgTableObject) {
        _lgTableObject = [LGTableObject adapterCellsWithCellClass:@[[UITableViewCell class]] style:UITableViewStylePlain];
    }
    return _lgTableObject;
}
@end
