//
//  PointTableViewCell.h
//  LGangTableView
//
//  Created by liugang on 2021/7/16.
//  Copyright © 2021 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PointCellBlock)(NSString *string) ;

typedef void(^CellBlock) (NSString *cellString);

@interface PointTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIButton *zanBtn;

@property (nonatomic,copy) PointCellBlock pointBlock;
@property (nonatomic,copy) CellBlock cellblock;

@end

NS_ASSUME_NONNULL_END
