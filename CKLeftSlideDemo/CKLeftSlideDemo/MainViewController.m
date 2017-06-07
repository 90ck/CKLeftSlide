//
//  MainViewController.m
//  CKLeftSlideDemo
//
//  Created by ck on 2017/6/6.
//  Copyright © 2017年 caike. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "NextViewController.h"
#import "CKLeftSlideViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"菜单"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    self.title = @"首页";
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"mainImage.jpg"];
    [self.view addSubview:imageView];
    
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    imageView.userInteractionEnabled = YES;
}

- (void)leftAction:(UIButton *)sender
{
    CKLeftSlideViewController *leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
    [leftSlide openLeftView];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
//    CKLeftSlideViewController *leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
//    [leftSlide closeLeftView];
    [self.navigationController pushViewController:[NextViewController new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
