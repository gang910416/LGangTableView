//
//  Mnustil.h
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mnustil : NSObject
//获取文字的高度
+(CGFloat)textHeight:(NSString *)str font:(UIFont *)font width:(CGFloat)width;

// 根据颜色字符串设置
+ (UIColor *)colorWithHexString:(NSString *)color;
@end

NS_ASSUME_NONNULL_END
