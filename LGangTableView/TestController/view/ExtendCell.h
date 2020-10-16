//
//  ExtendCell.h
//  TableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExtendCell : UITableViewCell

@property (nonatomic, strong) PersonModel *personModel;
@end

NS_ASSUME_NONNULL_END
