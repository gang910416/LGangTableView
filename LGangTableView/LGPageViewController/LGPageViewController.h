//
//  LGPageViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/27.
//  Copyright © 2020 liugang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SubTitleConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGPageViewController : UIViewController
- (instancetype)initWithTitleSubTitleConfig:(SubTitleConfig *)config controllers:(NSArray *)controllers;
@end

NS_ASSUME_NONNULL_END
