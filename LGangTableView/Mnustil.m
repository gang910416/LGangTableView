//
//  Mnustil.m
//  LGangTableView
//
//  Created by liugang on 2020/10/16.
//  Copyright © 2020 liugang. All rights reserved.
//

#import "Mnustil.h"

@implementation Mnustil

+(CGFloat)textHeight:(NSString *)str font:(UIFont *)font width:(CGFloat)width{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//Attribute传和label设定的一样
    NSDictionary * attributes = @{
                                  NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
//这里的size，width传label的宽，高默认都传MAXFLOAT
    CGSize textRect = CGSizeMake(width, MAXFLOAT);
    CGFloat textHeight = [str boundingRectWithSize: textRect
                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:attributes
                                           context:nil].size.height;
    return textHeight;
}
@end
