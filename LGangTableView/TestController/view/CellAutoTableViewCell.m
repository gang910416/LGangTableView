//
//  CellAutoTableViewCell.m
//  LGangTableView
//
//  Created by liugang on 2020/10/17.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "CellAutoTableViewCell.h"

@interface CellAutoTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *contentLabel;

@end

@implementation CellAutoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellAutosModel:(CellAutosModel *)cellAutosModel{
    self.titleLabel.text = cellAutosModel.title;
    self.contentLabel.text = cellAutosModel.content;
}

@end
