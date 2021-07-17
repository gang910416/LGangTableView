//
//  CustemViewC.m
//  LGangTableView
//
//  Created by liugang on 2020/11/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "CustemViewC.h"
#import "UIButton+Block.h"
#import "UILabel+Category.h"
#import "UIViewExt.h"
#import "UIAlertController+Category.h"
@interface CustemViewC ()

@end

@implementation CustemViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *btn = [UIButton createBtnFrame:CGRectMake(100, 200, 200, 50) title:@"提示框" imageName:@"ditu" titleColor:UIColor.redColor bgImageName:nil font:[UIFont systemFontOfSize:18] action:^(UIButton *button) {
        [UIAlertController showAlertCntrollerWithViewController:self alertControllerStyle:UIAlertControllerStyleAlert title:@"温馨提示" message:@"你确定要退出该账号吗？" CallBackBlock:^(NSInteger btnIndex) {
            NSLog(@"点击第%li个按钮",btnIndex);
        } cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定",nil];
    }];
    [self.view addSubview:btn];
    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(100, 400, 200, 30) text:@"政治言论不当政治言论不当政治言论不当" titleColor:UIColor.blackColor textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14] maxWidth:200];
    [self.view addSubview:label];
    
    UIButton *btn1 = [UIButton createBtnFrame:CGRectMake(100,CGRectGetMaxY(label.frame) + 10, 200, 50) title:@"底部选项提示" imageName:nil titleColor:UIColor.redColor bgImageName:nil font:[UIFont systemFontOfSize:14] action:^(UIButton *button) {
        [UIAlertController showAlertCntrollerWithViewController:self alertControllerStyle:UIAlertControllerStyleActionSheet title:@"举报该用户" message:@"举报" CallBackBlock:^(NSInteger btnIndex) {
            NSLog(@"点击了第%li个按钮",btnIndex);
        } cancelButtonTitle:@"取消" destructiveButtonTitle:@"" otherButtonTitles:@"政治言论不当",@"虚假广告", @"言语引起不适",@"不感兴趣",nil];
    }];
    
    [self.view addSubview:btn1];

    
}

@end
