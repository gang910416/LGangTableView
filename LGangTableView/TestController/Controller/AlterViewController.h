//
//  AlterViewController.h
//  LGangTableView
//
//  Created by liugang on 2021/7/17.
//  Copyright © 2021 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DismissBlock)(NSString *value);

@interface AlterViewController : UIViewController

@property (nonatomic, copy) DismissBlock dismissBlock;

@end

NS_ASSUME_NONNULL_END
