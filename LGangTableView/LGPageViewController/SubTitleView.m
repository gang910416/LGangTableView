//
//  SubTitleView.m
//  LGangTableView
//
//  Created by liugang on 2020/10/27.
//  Copyright © 2020 mibo02. All rights reserved.
//
#import "SubTitleView.h"
#import "Masonry.h"

#define kScreenWidth   CGRectGetWidth([[UIScreen mainScreen] bounds])  //获取屏幕宽度
#define kScreenHeight  CGRectGetHeight([[UIScreen mainScreen] bounds]) //获取屏幕高度
#define kSystemOriginColor [UIColor colorWithRed:0.96f green:0.39f blue:0.26f alpha:1.00f]
#define kSystemBlackColor  [UIColor colorWithRed:0.38f green:0.39f blue:0.40f alpha:1.00f]


@interface SubTitleView  ()<UIScrollViewDelegate>
/**
 *  滑块子视图
 */
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, strong)UIScrollView *scrollView;
//子标题按钮数组
@property (nonatomic, strong)NSMutableArray *subTitleButtonArray;

@property (nonatomic, strong)UIButton *currentSelectedButton;
@property (nonatomic, assign) CGFloat titleWidth;//选择按钮的宽度
@end


@implementation SubTitleView


- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
- (void)setTitleArray:(NSMutableArray<NSString *> *)titleArray
{
    _titleArray  = titleArray;
    [self configSubTitles];
}

- (void)configSubTitles
{
    //1.每一个titleView的宽度
    CGFloat height = 50;
     CGFloat width = (kScreenWidth - self.titleArray.count) / 4;
    self.titleWidth = width;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    self.scrollView.backgroundColor = UIColor.whiteColor;
    self.scrollView.scrollEnabled  = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.titleArray.count * width + 2 , height);
    [self addSubview:self.scrollView];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColor.lightGrayColor;
    lineView.frame = CGRectMake(0, 10, self.titleArray.count * width, height/2);
    [self.scrollView addSubview:lineView];
    
    
    for(NSInteger index = 0; index < _titleArray.count; index++) {
        NSString *title = [_titleArray objectAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.whiteColor;
        [btn setTitleColor:kSystemOriginColor forState:UIControlStateSelected];
        [btn setTitleColor:kSystemBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:kSystemOriginColor forState:UIControlStateHighlighted | UIControlStateSelected];
        if (index == 0) {
            btn.frame = CGRectMake(width * index , 0, width, height);
        }else{
            btn.frame = CGRectMake((width + 0.5) * index + 1 , 0, width, height);
        }
        btn.tag = index;
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(subTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.subTitleButtonArray addObject:btn];
        [self.scrollView addSubview:btn];
    }
    
    UIButton *firstBtn = [self.subTitleButtonArray firstObject];
    [self selectedAtButton:firstBtn isFirstStart:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

//当选中了某一个按钮

- (void)selectedAtButton:(UIButton *)btn isFirstStart:(BOOL)first
{
    btn.selected = YES;
    self.currentSelectedButton = btn;
    if (btn.tag > 2 ) {
       [self.scrollView setContentOffset:CGPointMake(self.titleWidth*(btn.tag - 1), 0) animated:YES];
    }else if(btn.tag < 3 && self.scrollView.contentOffset.x > 0){
         [self.scrollView setContentOffset:CGPointMake(- self.titleWidth*(btn.tag - 2), 0) animated:YES];
    }
    if (!first) {
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    }
    [self unselectedAllButton:btn];
}


//对所有按钮颜色执行反选操作
- (void)unselectedAllButton:(UIButton *)sender
{
    for (UIButton *sbtn in self.subTitleButtonArray) {
        if (sbtn == sender) {
            continue;
        }
        sbtn.selected = NO;
    }
}

- (void)trans2ShowAtIndex:(NSInteger)index {
    if(index < 0 || index >= self.subTitleButtonArray.count) {
        return;
    }
    UIButton *btn = [self.subTitleButtonArray objectAtIndex:index];
    [self selectedAtButton:btn isFirstStart:NO];
}
//按钮点击事件回调
- (void)subTitleBtnClick:(UIButton *)btn
{
    //如果点击的是当前选中的直接返回
    if (btn == self.currentSelectedButton) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(findSubTitleViewDidSelected:atIndex:title:)]) {
        [self.delegate findSubTitleViewDidSelected:self atIndex:[self.subTitleButtonArray indexOfObject:btn] title:btn.titleLabel.text];
    }
    [self selectedAtButton:btn isFirstStart:NO];
    
}


#pragma mark - getter

- (NSMutableArray *)subTitleButtonArray {
    if(!_subTitleButtonArray) {
        _subTitleButtonArray = [[NSMutableArray alloc] init];
    }
    return _subTitleButtonArray;
}
//下方滑块
- (UIView *)sliderView
{
    if (!_sliderView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kSystemOriginColor;
        //        [self addSubview:view];
        //        [view mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.size.mas_equalTo(CGSizeMake(30, 2));
        //            make.bottom.equalTo(self.mas_bottom);
        //            make.left.equalTo(self.mas_left).offset(5);
        //        }];
        _sliderView = view;
    }
    return _sliderView;
}

@end
