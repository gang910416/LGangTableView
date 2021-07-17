//
//  NewsTableViewCell.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "Mnustil.h"
@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.frame = CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 30, 20);
    [self.contentView addSubview:self.titleLabel];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 0, 100, 30);
//    [self.contentView addSubview:self.timeLabel];
    
    self.contentLabel = [UILabel new];
   
    self.contentLabel.frame = CGRectMake( 15,35,[UIScreen mainScreen].bounds.size.width - 30, 30);
//    self.contentLabel.backgroundColor = UIColor.redColor;
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}


- (void)setNewsModel:(NewsModel *)model{
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.content;
    self.contentLabel.frame = CGRectMake( 15,  35,  [UIScreen mainScreen].bounds.size.width - 30, [Mnustil textHeight:model.content font:[UIFont systemFontOfSize:14] width:[UIScreen mainScreen].bounds.size.width  - 30]);
}

-(void) cellConfigModel:(NewsModel *)model{
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.content;
    self.contentLabel.frame = CGRectMake( 15,  35,  [UIScreen mainScreen].bounds.size.width - 30, [Mnustil textHeight:model.content font:[UIFont systemFontOfSize:14] width:[UIScreen mainScreen].bounds.size.width  - 30]);
}

@end
