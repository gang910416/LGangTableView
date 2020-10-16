//
//  NewsModel.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

-(CGFloat) getCellHeight{
    CGFloat titleHeight = [Mnustil textHeight:self.title font:[UIFont systemFontOfSize:14] width:[UIScreen mainScreen].bounds.size.width  - 200];
    CGFloat contentHeight = [Mnustil textHeight:self.content font:[UIFont systemFontOfSize:14] width:[UIScreen mainScreen].bounds.size.width  - 30];
    return titleHeight + contentHeight + 25;
}

@end
