//
//  LQOrderTableViewCell.h
//  LGangTableView
//
//  Created by liugang on 2020/10/26.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LQOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) OrderListModel *orderListModel;

@property (nonatomic,weak) IBOutlet UILabel *titleLb;
@property (nonatomic,weak) IBOutlet UILabel *timeLb;
@end

NS_ASSUME_NONNULL_END
