//
//  LQOrderListModel.h
//  LGangTableView
//
//  Created by liugang on 2020/10/26.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListModel : NSObject


@property (nonatomic, assign) int goodsId;

//标题
@property (nonatomic, copy) NSString *title;

//time
@property (nonatomic, copy) NSString *time;


@end

NS_ASSUME_NONNULL_END
