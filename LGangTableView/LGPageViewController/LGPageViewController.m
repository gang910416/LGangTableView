//
//  LGPageViewController.m
//  LGangTableView
//
//  Created by liugang on 2020/10/27.
//  Copyright © 2020 mibo02. All rights reserved.
//

#import "LGPageViewController.h"
#import "SubTitleView.h"
#import "Masonry.h"


#define kXMLYBGGray [UIColor colorWithRed:0.92f green:0.93f blue:0.93f alpha:1.00f]

@interface LGPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,SubTitleViewDelegate>
@property (strong, nonatomic) SubTitleView *subTitleView;
@property (nonatomic, strong)NSArray *subTitleArray;
@property (nonatomic, strong)NSMutableArray *controllers;
@property (nonatomic, strong)NSArray *childVCName;
@property (nonatomic, weak)UIPageViewController *pageViewController;
@property (nonatomic, strong) SubTitleConfig *config;

@end

@implementation LGPageViewController

- (instancetype)initWithTitleSubTitleConfig:(SubTitleConfig *)config controllers:(NSArray *)controllers{
     self = [super init];
    if (self) {
        self.config = config;
        self.childVCName = controllers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PageViewController";
    [self.view addSubview:self.subTitleView];
    self.subTitleView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    self.view.backgroundColor = kXMLYBGGray;
    self.subTitleView.delegate =self;
    [self.subTitleView configSubTitleWith:self.config];
    [self configSubViews];
}
- (void)configSubViews
{
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.subTitleView.mas_bottom ).offset(10);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)findSubTitleViewDidSelected:(SubTitleView *)titleView atIndex:(NSInteger)index title:(NSString *)title
{
    [self.pageViewController setViewControllers:@[[self.controllers objectAtIndex:index]] direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
}

#pragma mark - UIPageViewControllerDelegate/UIPageViewControllerDataSource
//这个方法是返回前一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是第一个页面不可以向前滚动或翻页
-(nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexForViewController:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index - 1];
}
//这个方法是下一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是最后一个页面不可以向后滚动或翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexForViewController:viewController];
    if (index == NSNotFound || index == self.controllers.count - 1) {
        return nil;
    }
    return [self.controllers objectAtIndex:index + 1];
}
//返回多少个控制器
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.controllers.count;
}
#pragma mark -private
- (NSInteger)indexForViewController:(UIViewController *)controller
{
    return [self.controllers indexOfObject:controller];
}
//这个方法是在UIPageViewController结束滚动或翻页的时候触发
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *viewcontroller = self.pageViewController.viewControllers[0];
    
    NSUInteger index = [self indexForViewController:viewcontroller];
    
    [self.subTitleView trans2ShowAtIndex:index];
}
#pragma mark - getter

- (UIPageViewController *)pageViewController {
    if(!_pageViewController) {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        UIPageViewController *page = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        page.delegate = self;
        page.dataSource = self;
        //设置UIPageViewController初始显示的页面
        [page setViewControllers:@[[self.controllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self addChildViewController:page];
        
        [self.view addSubview:page.view];
        _pageViewController = page;
    }
    return _pageViewController;
}

- (NSMutableArray *)controllers {
    if(!_controllers) {
        _controllers = [[NSMutableArray alloc] init];
        for (NSString *title in self.childVCName) {
             UIViewController  *con = (UIViewController *) [[NSClassFromString(title) alloc]init];
            [_controllers addObject:con];
        }
    }
    return _controllers;
}


- (SubTitleView *)subTitleView{
    if (!_subTitleView) {
        _subTitleView = [[SubTitleView alloc]init];
    }
    return _subTitleView;
}

@end
