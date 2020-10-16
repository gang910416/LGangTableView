//
//  ExtendCell.m
//  TableView
////
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//


#import "ExtendCell.h"
@interface ExtendCell()
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *hobbyLabel;

@end


@implementation ExtendCell

- (void)setPersonModel:(PersonModel *)personModel{
    self.ageLabel.text = [NSString stringWithFormat:@"年龄:%ld",personModel.age];
    self.hobbyLabel.text = [NSString stringWithFormat:@"喜好:%@",personModel.hobby];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
