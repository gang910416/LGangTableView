//
//  LQOrderTableViewCell.m
//  LGangTableView
//
//  Created by liugang on 2020/10/26.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LQOrderTableViewCell.h"

@implementation LQOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderListModel:(OrderListModel *)orderListModel{
    self.titleLb.text = orderListModel.title;
    self.timeLb.text = orderListModel.time;
}



@end
