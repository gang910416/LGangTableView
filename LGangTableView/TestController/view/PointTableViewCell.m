//
//  PointTableViewCell.m
//  LGangTableView
//
//  Created by liugang on 2021/7/16.
//  Copyright © 2021 liugang. All rights reserved.
//

#import "PointTableViewCell.h"

@implementation PointTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(IBAction)DianzanClick:(id)sender{
    self.pointBlock(@"123");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
