//
//  CKLeftSlideViewController.m
//  CKLeftSlideDemo
//
//  Created by ck on 2017/6/6.
//  Copyright © 2017年 caike. All rights reserved.
//

#import "CKLeftSlideViewController.h"




@interface CKLeftSlideViewController ()<UIGestureRecognizerDelegate>
{
    //记录起始位置
    CGPoint _originalPoint;
}

/** 蒙版 */
@property (nonatomic, strong) UIView *coverView;

/** 左侧菜单视图宽度 */
@property (nonatomic, assign) CGFloat menuWidth;

/** 留白宽度 */
@property (nonatomic, assign) CGFloat emptyWidth;

@end

@implementation CKLeftSlideViewController

- (instancetype)initWithLeftVc:(UIViewController *)leftVc mainVc:(UIViewController *)mainVc
{
    if (self = [super init]) {
        [self addChildViewController:leftVc];
        [self addChildViewController:mainVc];
        self.leftViewController = leftVc;
        self.mainViewController = mainVc;
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.leftViewController.view];
        [self.view addSubview:self.mainViewController.view];
            
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.leftViewController.view.frame = self.view.frame;
    self.mainViewController.view.frame = self.view.frame;
    [self updateLeftViewFrame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    [self.mainViewController.view addGestureRecognizer:pan];
    
    self.coverView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0;
    self.coverView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.coverView addGestureRecognizer:tap];

    [self.mainViewController.view addSubview:self.coverView];
}


#pragma mark PanDelegate
//设置拖拽响应范围、设置Navigation子视图不可拖拽
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //设置Navigation子视图不可拖拽
    if ([self.mainViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self.mainViewController;
        if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
            return NO;
        }
    }
    //如果Tabbar的当前视图是UINavigationController，设置UINavigationController子视图不可拖拽
    if ([self.mainViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController*)self.mainViewController;
        UINavigationController *navigationController = tabbarController.selectedViewController;
        if ([navigationController isKindOfClass:[UINavigationController class]]) {
            if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
                return NO;
            }
        }
    }
    //设置拖拽响应范围
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
//        //拖拽响应范围是距离边界是空白位置宽度
//        CGFloat actionWidth = self.emptyWidth;
//        CGPoint point = [touch locationInView:gestureRecognizer.view];
//        if (point.x <= actionWidth || point.x > self.view.bounds.size.width - actionWidth) {
//            return YES;
//        } else {
//            return NO;
//        }
//    }
    return YES;
}


//滑动手势
- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            //记录起始点
            _originalPoint = CGPointMake(CGRectGetMinX(self.mainViewController.view.frame),CGRectGetMidY(self.mainViewController.view.frame));
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [pan translationInView:self.view];
            CGFloat x = _originalPoint.x + point.x;
            
            //最左侧边界x = 0
            x = x > 0 ? x : 0;
            //最右侧边界x = self.menuWidth
            x = x < self.menuWidth ? x : self.menuWidth;
            
            self.mainViewController.view.center = CGPointMake(x + CGRectGetWidth(self.mainViewController.view.frame)/2, CGRectGetMidY(self.mainViewController.view.frame));
            [self updateLeftViewFrame];
            
            
            //更新遮罩层的透明度
            self.coverView.hidden = NO;
            self.coverView.alpha = CGRectGetMinX(self.mainViewController.view.frame)/self.menuWidth * MaxCoverAlpha;

        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (CGRectGetMinX(self.mainViewController.view.frame) <= self.menuWidth/2) {
                [self closeLeftView];
            }
            else{
                [self openLeftView];
            }
        }
            break;
        default:
            break;
    }
}

//tap手势
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    [self closeLeftView];
}

//打开菜单视图
- (void)openLeftView
{
    self.coverView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.mainViewController.view.center = CGPointMake(self.view.frame.size.width/2 + self.menuWidth, CGRectGetMidY(self.mainViewController.view.frame));
        [self updateLeftViewFrame];
        self.coverView.alpha = MaxCoverAlpha;
    } completion:^(BOOL finished) {
        
    }];
}

//关闭菜单视图
- (void)closeLeftView
{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.mainViewController.view.center = CGPointMake(self.view.frame.size.width/2, CGRectGetMidY(self.mainViewController.view.frame));
        [self updateLeftViewFrame];
        self.coverView.alpha = 0;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
    }];

}

//更新左侧菜单位置
- (void)updateLeftViewFrame
{
    self.leftViewController.view.center = CGPointMake((CGRectGetMinX(self.mainViewController.view.frame) + self.emptyWidth)/2, CGRectGetMidY(self.mainViewController.view.frame));
}

//菜单宽度
- (CGFloat)menuWidth
{
    return self.view.bounds.size.width * MenuWidthScale;
}

//空白宽度
- (CGFloat)emptyWidth
{
    return self.view.bounds.size.width * (1-MenuWidthScale);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//重写导航控制器get方法
- (UINavigationController *)navigationController
{
    if ([self.mainViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)self.mainViewController;
    }
    else if ([self.mainViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVc = (UITabBarController *)self.mainViewController;
        if ([tabVc.selectedViewController isKindOfClass:[UINavigationController class]]) {
             return tabVc.selectedViewController;
        }
        return nil;
    }
    return nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
