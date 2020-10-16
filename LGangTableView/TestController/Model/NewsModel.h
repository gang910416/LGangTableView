//
//  NewsModel.h
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LGBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : LGBaseModel
//标题
@property (nonatomic, copy) NSString *title;

//时间
@property (nonatomic, copy) NSString *time;

//neirong 
@property (nonatomic, copy) NSString *content;



@end

NS_ASSUME_NONNULL_END
