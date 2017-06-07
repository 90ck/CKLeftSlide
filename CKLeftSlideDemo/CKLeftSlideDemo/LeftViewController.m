//
//  LeftViewController.m
//  CKLeftSlideDemo
//
//  Created by ck on 2017/6/6.
//  Copyright © 2017年 caike. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "CKLeftSlideViewController.h"
#import "NextViewController.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame)*MenuWidthScale, CGRectGetHeight(self.view.frame))];
    imageView.image = [UIImage imageNamed:@"leftImage.jpg"];
    [self.view addSubview:imageView];
   
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    imageView.userInteractionEnabled = YES;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    CKLeftSlideViewController *leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
    [leftSlide closeLeftView];
    [leftSlide.navigationController pushViewController:[NextViewController new] animated:NO];

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

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
