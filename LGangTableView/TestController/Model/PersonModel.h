//
//  PersonModel.h
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "LGBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonModel : LGBaseModel
//名字
@property (nonatomic, copy) NSString *name;

//年龄
@property (nonatomic, assign) NSInteger age;

//喜好
@property (nonatomic, copy) NSString *hobby;

//简介
@property (nonatomic, copy) NSString *info;

@end

NS_ASSUME_NONNULL_END
