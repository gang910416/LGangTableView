//
//  NewsTableAdapter.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "NewsTableAdapter.h"
#import "PersonModel.h"
@implementation NewsTableAdapter

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionLab = [UILabel new];
    PersonModel *p = [self.tableViewDatas[section] firstObject];
    sectionLab.text = p.name;
    return sectionLab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *sectionLab = [UILabel new];
    sectionLab.backgroundColor = UIColor.orangeColor;
    PersonModel *p = [self.tableViewDatas[section] firstObject];
    sectionLab.text = p.info;
    return sectionLab;
}

@end
