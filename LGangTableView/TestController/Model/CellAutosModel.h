//
//  AutoModel.h
//  LGangTableView
//
//  Created by liugang on 2020/10/17.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellAutosModel : NSObject
//标题
@property (nonatomic, copy) NSString *title;

//时间
@property (nonatomic, copy) NSString *time;

//neirong
@property (nonatomic, copy) NSString *content;


@end

NS_ASSUME_NONNULL_END
