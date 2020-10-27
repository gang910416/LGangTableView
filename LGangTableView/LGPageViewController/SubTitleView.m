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
@property (nonatomic, assign) CGFloat silderWidth;// 下划线的宽度
@property (nonatomic, strong) SubTitleConfig *config;
@end


@implementation SubTitleView


- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
- (void) configSubTitleWith:(SubTitleConfig *)config{
    self.config = config;
    self.silderWidth = (config.siderWith > 0)?config.siderWith:30;
    _titleArray  = config.titleArray;
    [self configSubTitles];
}

//- (void)setTitleArray:(NSMutableArray<NSString *> *)titleArray
//{
//    _titleArray  = titleArray;
//    [self configSubTitles];
//}

- (void)configSubTitles
{
    //1.每一个titleView的宽度
    CGFloat height = (self.config.height > 0)?self.config.height:50;
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
        [btn setTitleColor:(self.config.selectedColor != nil)?self.config.selectedColor:kSystemOriginColor forState:UIControlStateSelected];
        [btn setTitleColor:(self.config.nomalColor != nil)?self.config.nomalColor:kSystemBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:(self.config.selectedColor != nil)?self.config.selectedColor:kSystemOriginColor forState:UIControlStateHighlighted | UIControlStateSelected];
        if (index == 0) {
            btn.frame = CGRectMake(width * index , 0, width, height - 3);
        }else{
            btn.frame = CGRectMake((width + 0.5) * index + 1 , 0, width, height - 3);
        }
        btn.tag = index;
        btn.titleLabel.font = [UIFont systemFontOfSize:(self.config.fontSize > 0)?self.config.fontSize: 16];
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(subTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.subTitleButtonArray addObject:btn];
        [self.scrollView addSubview:btn];
    }
    
    [self.scrollView addSubview:self.sliderView];
    //    self.sliderView.frame = CGRectMake((width - 30)/2, height - 3, 30, 2);
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(height - 3);
        make.left.mas_equalTo((width - self.silderWidth)/2);
        make.width.mas_equalTo(self.silderWidth);
        make.height.mas_equalTo(2);
    }];
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
    [self.sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).offset(btn.frame.origin.x + btn.frame.size.width / 2 - self.silderWidth/2);
    }];
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
            sbtn.titleLabel.font = [UIFont systemFontOfSize:(self.config.sel_fontSize > 0)?self.config.sel_fontSize: 19];
            continue;
        }
        sbtn.selected = NO;
        sbtn.titleLabel.font = [UIFont systemFontOfSize:(self.config.fontSize > 0)?self.config.fontSize: 16];
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
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor =(self.config.selectedColor != nil)?self.config.selectedColor:kSystemOriginColor;
    }
    return _sliderView;
}

@end
