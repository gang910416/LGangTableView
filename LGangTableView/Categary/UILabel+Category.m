//
//  UILabel+Category.m
//  iOS常见控件的封装
//
//  Created by 张建 on 16/10/18.
//  Copyright © 2016年 张建. All rights reserved.
//

#import "UILabel+Category.h"
#import "UIViewExt.h"
@implementation UILabel (Category)

+ (instancetype)createLabelWithFrame:(CGRect)frame text:(NSString *)text titleColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = font;
    label.numberOfLines = 0;
    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font,} context:nil];
    label.height =  rect.size.height;
    return label;
}

-(CGFloat)getAttributeLabelHeightWithText:(NSString *)text maxWidth:(CGFloat)maxWidth lineSpacing:(CGFloat)lineSpacing
{
    self.numberOfLines = 0;
    self.width = maxWidth;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    [style setLineSpacing:lineSpacing];

    CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:style} context:nil];
    
    return rect.size.height;
    
}

@end
