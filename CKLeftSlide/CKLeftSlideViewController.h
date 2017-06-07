//
//  CKLeftSlideViewController.h
//  CKLeftSlideDemo
//
//  Created by ck on 2017/6/6.
//  Copyright © 2017年 caike. All rights reserved.
//

#import <UIKit/UIKit.h>

//菜单的显示区域占屏幕宽度的百分比
static CGFloat MenuWidthScale = 0.8f;
//遮罩层最高透明度
static CGFloat MaxCoverAlpha = 0.2f;

@interface CKLeftSlideViewController : UIViewController

//左边视图控制器
@property (nonatomic, strong) UIViewController *leftViewController;

//右边视图控制器 一般为UINavigationController 或者 UITabBarController
@property (nonatomic, strong) UIViewController *mainViewController;


//初始化方法
- (instancetype)initWithLeftVc:(UIViewController *)leftVc mainVc:(UIViewController *)mainVc;


//打开菜单视图
- (void)openLeftView;

//关闭菜单视图
- (void)closeLeftView;
@end
